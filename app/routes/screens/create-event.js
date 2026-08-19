import Route from '@ember/routing/route';
import { createEventMock } from 'ulx-lab/mocks/create-event';

export default class CreateEventRoute extends Route {
  model() {
    return { ...createEventMock };
  }
}
