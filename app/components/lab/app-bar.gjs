import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { LinkTo } from '@ember/routing';
import { array } from '@ember/helper';
import { UlxToolbar, UlxIconButton, UlxSlidePane } from 'ulx-components';
import LabArgControls from 'ulx-lab/components/lab/arg-controls';
import {
  configurableScreens,
  screenIdFromRouteName,
  settingsForScreen,
} from 'ulx-lab/data/screen-settings';

const SETTINGS_OPEN_KEY = 'ulx-lab:settings-open';
const CONFIGURABLE_SCREENS = configurableScreens();
/** Lab inspector (Settings control + slide pane). Re-enable when needed. */
const SETTINGS_ENABLED = false;

export default class LabAppBar extends Component {
  @service router;

  @tracked isSettingsOpen =
    SETTINGS_ENABLED &&
    globalThis.sessionStorage?.getItem(SETTINGS_OPEN_KEY) === '1';

  get currentSettings() {
    return settingsForScreen(
      screenIdFromRouteName(this.router.currentRouteName),
    );
  }

  get settingsTitle() {
    const screenTitle = this.currentSettings.screen?.title;

    return screenTitle ? `${screenTitle} settings` : 'Settings';
  }

  @action
  openSettings() {
    if (!SETTINGS_ENABLED) {
      return;
    }

    this.isSettingsOpen = true;
    globalThis.sessionStorage?.setItem(SETTINGS_OPEN_KEY, '1');
  }

  @action
  closeSettings() {
    this.isSettingsOpen = false;
    globalThis.sessionStorage?.removeItem(SETTINGS_OPEN_KEY);
  }

  <template>
    <header
      class="position-sticky top-0 z-10 px-6 py-2 border-b bg-layer1"
      data-qa="lab-app-bar"
    >
      <UlxToolbar aria-label="ULX Lab">
        <:start>
          <LinkTo @route="home.event-listing" class="medium-font">ULX Lab</LinkTo>
        </:start>
        <:end>
          {{#if SETTINGS_ENABLED}}
            <UlxIconButton
              @label="Settings"
              @iconLeft="settings-icon-01"
              @iconComponentClass="bs-icons1"
              @iconSize="s16"
              @size="s-size"
              @variant="secondary"
              @text={{true}}
              @onClick={{this.openSettings}}
              @dataQa="lab-open-settings"
              aria-expanded={{this.isSettingsOpen}}
            />
          {{/if}}
        </:end>
      </UlxToolbar>
    </header>
    {{#if SETTINGS_ENABLED}}
    <UlxSlidePane
      @visible={{this.isSettingsOpen}}
      @title={{this.settingsTitle}}
      @position="right"
      @size="m-size"
      @hideFooter={{true}}
      @onHide={{this.closeSettings}}
      @dataQa="lab-settings-pane"
    >
      {{#if this.currentSettings.hasControls}}
        <p class="text-secondary mb-4">
          Changes write into the screen source. The demo page stays a demo.
        </p>
        {{#each
          (array this.currentSettings.screenId) key="@identity"
          as |screenId|
        }}
          <LabArgControls
            @schema={{this.currentSettings.schema}}
            @screenId={{screenId}}
          />
        {{/each}}
      {{else}}
        {{#if this.currentSettings.screen}}
          <p class="text-secondary mb-4">
            {{this.currentSettings.screen.title}}
            has no configurable properties yet. Choose another screen.
          </p>
        {{else}}
          <p class="text-secondary mb-4">
            Open a demo, then use Settings to configure it. Or choose a screen
            below.
          </p>
        {{/if}}
        <ul class="flex flex-col gap-4">
          {{#each CONFIGURABLE_SCREENS as |screen|}}
            <li>
              {{#if screen.model}}
                <LinkTo
                  @route={{screen.route}}
                  @model={{screen.model}}
                  class="medium-font"
                >
                  {{screen.title}}
                </LinkTo>
              {{else}}
                <LinkTo @route={{screen.route}} class="medium-font">
                  {{screen.title}}
                </LinkTo>
              {{/if}}
              <p class="text-secondary">{{screen.description}}</p>
            </li>
          {{/each}}
        </ul>
      {{/if}}
    </UlxSlidePane>
    {{/if}}
  </template>
}
