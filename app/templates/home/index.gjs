import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import EventListing from 'ulx-lab/components/screens/event-listing';
import CreateEventModal from 'ulx-lab/components/screens/create-event-modal';
import { UlxToast } from 'ulx-components';

export default class HomeEventListingPage extends Component {
  @tracked isCreateOpen = false;
  @tracked messages = [];

  @action
  openCreate() {
    this.isCreateOpen = true;
  }

  @action
  closeCreate() {
    this.isCreateOpen = false;
  }

  @action
  save(payload) {
    this.isCreateOpen = false;
    this.messages = [
      ...this.messages,
      {
        id: `home-create-event-${Date.now()}`,
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
    <EventListing
      @model={{@model}}
      @onCreateEvent={{this.openCreate}}
      @eventRoute="event-home.manage.event-info"
    />
    <CreateEventModal
      @isOpen={{this.isCreateOpen}}
      @model={{@model.createEvent}}
      @onSave={{this.save}}
      @onCancel={{this.closeCreate}}
    />
    <UlxToast @messages={{this.messages}} @onClose={{this.removeMessage}} />
  </template>
}
