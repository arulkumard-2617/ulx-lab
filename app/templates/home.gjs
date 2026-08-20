import Component from '@glimmer/component';
import { service } from '@ember/service';
import pageTitle from 'ember-page-title/helpers/page-title';
import HomeTopBar from 'ulx-lab/components/commons/home-top-bar';
import HomeLeftBar from 'ulx-lab/components/commons/home-left-bar';
import PortalSettingsLeftBar from 'ulx-lab/components/commons/portal-settings-left-bar';

export default class HomeTemplate extends Component {
  @service router;

  get isPortalSettings() {
    return (this.router.currentRouteName ?? '').startsWith('home.portal-settings');
  }

  get pageTitle() {
    return this.isPortalSettings ? 'Portal Settings' : 'Home';
  }

  <template>
    {{pageTitle this.pageTitle}}
    <div id="oe-service-root" class="fxb" data-qa="home-page">
      <div class="fxgrow">
        <HomeTopBar @model={{@model}} />
        <div class="uls-page old-ui-view hgt2 page-event-listing">
          {{#if this.isPortalSettings}}
            <PortalSettingsLeftBar @model={{@model}} />
          {{else}}
            <HomeLeftBar @model={{@model}} />
          {{/if}}
          <main tabindex="0" class="page-content-panel uls-container-old">
            {{outlet}}
          </main>
        </div>
      </div>
    </div>
  </template>
}
