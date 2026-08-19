import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import pageTitle from 'ember-page-title/helpers/page-title';
import TicketClassForm from 'ulx-lab/components/screens/ticket-class-form';
import { UlxToast } from 'ulx-components';

export default class TicketClassFormPage extends Component {
  @tracked messages = [];

  @action
  save(payload) {
    this.messages = [
      ...this.messages,
      {
        id: `ticket-class-saved-${Date.now()}`,
        variant: 'success',
        summary: `Saved ${payload.name}.`,
      },
    ];
  }

  @action
  cancel() {
    this.messages = [
      ...this.messages,
      {
        id: `ticket-class-cancelled-${Date.now()}`,
        variant: 'info',
        summary: 'Changes discarded.',
      },
    ];
  }

  @action
  removeMessage(message) {
    this.messages = this.messages.filter((item) => item.id !== message.id);
  }

  <template>
    {{pageTitle "Ticket class form"}}
    <h1 class="h7-font mb-6">Ticket class form</h1>
    <TicketClassForm
      @model={{@model}}
      @onSave={{this.save}}
      @onCancel={{this.cancel}}
    />
    <UlxToast @messages={{this.messages}} @onClose={{this.removeMessage}} />
  </template>
}
