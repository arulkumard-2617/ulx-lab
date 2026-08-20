import Component from '@glimmer/component';
import { service } from '@ember/service';
import pageTitle from 'ember-page-title/helpers/page-title';

export default class ApplicationTemplate extends Component {
  @service router;

  get usesPageChrome() {
    const name = this.router.currentRouteName ?? '';
    return name.startsWith('home') || name.startsWith('event-home');
  }

  <template>
    {{pageTitle "ULX Lab"}}
    {{#if this.usesPageChrome}}
      {{outlet}}
    {{else}}
      <div class="p-6">
        {{outlet}}
      </div>
    {{/if}}
  </template>
}
