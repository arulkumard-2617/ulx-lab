import Route from '@ember/routing/route';
import { homeChromeMock } from 'ulx-lab/mocks/page-chrome';
import { eventsMock } from 'ulx-lab/mocks/events';
import { createEventMock } from 'ulx-lab/mocks/create-event';

export default class HomeRoute extends Route {
  model() {
    return {
      ...homeChromeMock,
      events: eventsMock,
      createEvent: { ...createEventMock },
      activeTab: 'running',
      activeNavId: 'events',
    };
  }
}
