import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import pageTitle from 'ember-page-title/helpers/page-title';
import CreateEventModal from 'ulx-lab/components/screens/create-event-modal';
import { UlxButton, UlxToast } from 'ulx-components';

export default class CreateEventPage extends Component {
  @tracked isOpen =
    globalThis.sessionStorage?.getItem('ulx-lab:create-event:open') === '1';
  @tracked messages = [];

  @action
  openModal() {
    this.isOpen = true;
    globalThis.sessionStorage?.setItem('ulx-lab:create-event:open', '1');
  }

  @action
  closeModal() {
    this.isOpen = false;
    globalThis.sessionStorage?.removeItem('ulx-lab:create-event:open');
  }

  @action
  save(payload) {
    this.isOpen = false;
    globalThis.sessionStorage?.removeItem('ulx-lab:create-event:open');
    this.messages = [
      ...this.messages,
      {
        id: `create-event-saved-${Date.now()}`,
        variant: 'success',
        summary: payload.eventName
          ? `Created ${payload.eventName}.`
          : 'Event created.',
      },
    ];
  }

  @action
  removeMessage(message) {
    this.messages = this.messages.filter((item) => item.id !== message.id);
  }

  <template>
    {{pageTitle "Create Event"}}
    <h1 class="h7-font mb-2">Create Event</h1>
    <p class="text-secondary mb-6">
      Presentational modal with static data. Copy
      <code>create-event-modal.gjs</code>
      into Eventz; wire save and i18n there. Use Settings in the top bar to
      change modal size.
    </p>
    <UlxButton
      @label="Create Event"
      @variant="primary"
      @onClick={{this.openModal}}
      @dataQa="create-event-button"
    />
    <CreateEventModal
      @isOpen={{this.isOpen}}
      @model={{@model}}
      @onSave={{this.save}}
      @onCancel={{this.closeModal}}
    />
    <UlxToast @messages={{this.messages}} @onClose={{this.removeMessage}} />
  </template>
}
