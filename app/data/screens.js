/**
 * Register every lab screen here so the home list and Eventz handoff stay in sync.
 * When adding a screen: presentational .gjs, mock, route, route template, then this entry.
 */
export const SCREENS = [
  {
    id: 'home',
    title: 'Home',
    route: 'home.index',
    description:
      'Home event listing. Click an event title or Manage to open Basic Details.',
  },
  {
    id: 'portal-settings',
    title: 'Portal Settings',
    route: 'home.portal-settings',
    description: 'Home chrome with Portal Settings. Add the form when you need it.',
  },
  {
    id: 'event-info',
    title: 'Event Info',
    route: 'event-home.manage.event-info',
    description: 'Event chrome with Basic Details. Add more event pages later.',
  },
  {
    id: 'ticket-class-form',
    title: 'Ticket class form',
    route: 'screens.ticket-class-form',
    description: 'Seed presentational form with static ticket-class data.',
  },
  {
    id: 'create-event',
    title: 'Create Event',
    route: 'screens.create-event',
    description: 'Presentational create-event modal with static data.',
  },
  {
    id: 'ticket-list',
    title: 'Tickets',
    route: 'screens.ticket-list',
    description:
      'Empty state, ticket-details slide pane, then a list from JSON sample data.',
  },
];
