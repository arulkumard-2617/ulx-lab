import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { findEventById, eventsMock } from 'ulx-lab/mocks/events';

export default class CurrentEventService extends Service {
  @tracked id = eventsMock[0]?.id;

  select(id) {
    this.id = id;
  }

  get event() {
    return findEventById(this.id);
  }
}
