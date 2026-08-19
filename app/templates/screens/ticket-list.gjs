import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import pageTitle from 'ember-page-title/helpers/page-title';
import TicketList from 'ulx-lab/components/screens/ticket-list';
import { UlxToast } from 'ulx-components';

export default class TicketListPage extends Component {
  @tracked messages = [];

  @action
  save(payload) {
    this.messages = [
      ...this.messages,
      {
        id: `ticket-saved-${Date.now()}`,
        variant: 'success',
        summary: payload.name ? `Saved ${payload.name}.` : 'Ticket saved.',
      },
    ];
  }

  @action
  removeMessage(message) {
    this.messages = this.messages.filter((item) => item.id !== message.id);
  }

  <template>
    {{pageTitle "Tickets"}}
    <h1 class="h7-font mb-6">Tickets</h1>
    <TicketList @model={{@model}} @onSave={{this.save}} />
    <UlxToast @messages={{this.messages}} @onClose={{this.removeMessage}} />
  </template>
}
