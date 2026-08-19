import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';
import eq from 'ember-truth-helpers/helpers/eq';
import { homeNavItems } from 'ulx-lab/mocks/page-chrome';

export default class HomeLeftBar extends Component {
  @tracked activeId = this.args.model?.activeNavId ?? 'events';

  get items() {
    return this.args.model?.navItems ?? homeNavItems;
  }

  @action
  selectItem(item, event) {
    event?.preventDefault();
    this.activeId = item.id;
    this.args.onSelect?.(item);
  }

  <template>
    <div
      class="page-left-panel new-ui-only fixed-panel"
      data-qa="home-left-bar"
    >
      <nav tabindex="0" class="uls-vertical-menu">
        <ul class="menu-items" aria-label="Left Menu">
          {{#each this.items as |item|}}
            <li
              class="menu-item {{if (eq item.id this.activeId) 'active'}}"
            >
              {{#if item.route}}
                <LinkTo
                  @route={{item.route}}
                  @activeClass=""
                  data-a11y="focus link"
                  data-qa="home-left-bar-{{item.id}}"
                >
                  <span class="grb gp2 fvc">
                    <i
                      class="bs-icons1 {{item.icon}} s18"
                      aria-hidden="true"
                    ></i>
                    {{item.label}}
                  </span>
                </LinkTo>
              {{else}}
                <a
                  href="#"
                  data-a11y="focus link"
                  data-qa="home-left-bar-{{item.id}}"
                  {{on "click" (fn this.selectItem item)}}
                >
                  <span class="grb gp2 fvc">
                    <i
                      class="bs-icons1 {{item.icon}} s18"
                      aria-hidden="true"
                    ></i>
                    {{item.label}}
                  </span>
                </a>
              {{/if}}
            </li>
          {{/each}}
        </ul>
      </nav>
    </div>
  </template>
}
