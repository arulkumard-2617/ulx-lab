import Route from '@ember/routing/route';
import { ticketClassMock } from 'ulx-lab/mocks/ticket-class';

export default class TicketClassFormRoute extends Route {
  model() {
    return { ...ticketClassMock };
  }
}
