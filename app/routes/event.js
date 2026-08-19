import Route from '@ember/routing/route';
import { eventToChrome, findEventById } from 'ulx-lab/mocks/events';

export default class EventRoute extends Route {
  model(params) {
    return eventToChrome(findEventById(params.event_id));
  }
}
