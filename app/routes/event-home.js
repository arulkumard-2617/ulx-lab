import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { eventToChrome } from 'ulx-lab/mocks/events';

export default class EventHomeRoute extends Route {
  @service currentEvent;

  model() {
    return eventToChrome(this.currentEvent.event);
  }
}
