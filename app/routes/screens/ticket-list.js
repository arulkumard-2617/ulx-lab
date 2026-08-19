import Route from '@ember/routing/route';
import { ticketsMock } from 'ulx-lab/mocks/tickets';

export default class TicketListRoute extends Route {
  model() {
    return {
      tickets: (ticketsMock.tickets ?? []).map((ticket) => ({ ...ticket })),
      draft: { ...ticketsMock.draft },
    };
  }
}
