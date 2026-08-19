import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { array, fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';
import eq from 'ember-truth-helpers/helpers/eq';
import { eventNavItems } from 'ulx-lab/mocks/page-chrome';

export default class EventLeftBar extends Component {
  @tracked activeId = this.args.model?.activeNavId ?? 'manage';
  @tracked isSubmenuOpen = Boolean(
    (this.args.model?.navItems ?? eventNavItems).find(
      (item) => item.id === (this.args.model?.activeNavId ?? 'manage'),
    )?.submenu,
  );

  get items() {
    return this.args.model?.navItems ?? eventNavItems;
  }

  get eventId() {
    return this.args.model?.event?.id;
  }

  get selectedItem() {
    return this.items.find((item) => item.id === this.activeId) ?? this.items[0];
  }

  get submenuActive() {
    return this.isSubmenuOpen && Boolean(this.selectedItem?.submenu?.length);
  }

  @action
  selectItem(item, event) {
    event?.preventDefault();
    this.activeId = item.id;
    this.isSubmenuOpen = Boolean(item.submenu?.length);
    this.args.onSelect?.(item);
  }

  @action
  closeSubmenu() {
    this.isSubmenuOpen = false;
  }

  <template>
    <div
      class="page-left-panel {{if this.submenuActive 'sub-menu-active'}}"
      data-qa="event-left-bar"
    >
      <div class="uls-left-navigation-bar">
        <div class="uls-nav-items">
          {{#each this.items as |item|}}
            <a
              href="#"
              class="nav-item {{if (eq item.id this.activeId) 'active'}}"
              {{on "click" (fn this.selectItem item)}}
              data-qa="event-left-bar-{{item.id}}"
            >
              <i class="bs-icons1 {{item.icon}}" aria-hidden="true"></i>
              {{item.label}}
            </a>
          {{/each}}
        </div>
        {{#if this.submenuActive}}
          <div class="uls-navigation-panel open">
            <button
              type="button"
              class="panel-pin-option"
              {{on "click" this.closeSubmenu}}
              data-qa="event-left-bar-collapse"
              aria-label="Collapse submenu"
            >
              <i class="bs-icons1 pin-icon s20 collapse-icon" aria-hidden="true"></i>
            </button>
            <div class="panel-items">
              {{#each this.selectedItem.submenu as |subItem|}}
                {{#if (eq subItem.route "event.index")}}
                  <LinkTo
                    @route="event.index"
                    @model={{this.eventId}}
                    class="panel-item"
                    data-qa="event-left-bar-{{subItem.id}}"
                  >
                    <i class="bs-icons1 {{subItem.icon}}" aria-hidden="true"></i>
                    {{subItem.label}}
                  </LinkTo>
                {{else if subItem.route}}
                  <LinkTo
                    @route={{subItem.route}}
                    @models={{array this.eventId subItem.id}}
                    class="panel-item"
                    data-qa="event-left-bar-{{subItem.id}}"
                  >
                    <i class="bs-icons1 {{subItem.icon}}" aria-hidden="true"></i>
                    {{subItem.label}}
                  </LinkTo>
                {{else}}
                  <a
                    href="#"
                    class="panel-item"
                    data-qa="event-left-bar-{{subItem.id}}"
                  >
                    <i class="bs-icons1 {{subItem.icon}}" aria-hidden="true"></i>
                    {{subItem.label}}
                  </a>
                {{/if}}
              {{/each}}
            </div>
          </div>
        {{/if}}
      </div>
    </div>
  </template>
}
