export const homeChromeMock = {
  brandName: 'Default Space',
  userInitials: 'AR',
};

export const eventChromeMock = {
  eventName: 'New one for meeting',
  status: 'COMPLETED',
  eventWhen: 'Thu Jul 23, 2026 - 01:00 PM (IST)',
  language: 'English',
  userInitials: 'AR',
};

export const homeNavItems = [
  {
    id: 'events',
    label: 'Events',
    icon: 'events-icon',
    route: 'home.index',
  },
  { id: 'attendee-profiles', label: 'Attendee Profiles', icon: 'team-icon' },
  { id: 'contacts', label: 'Contacts', icon: 'contact-icon' },
  { id: 'space-settings', label: 'Space Settings', icon: 'settings-icon' },
];

export const eventNavItems = [
  { id: 'dashboard', label: 'Dashboard', icon: 'overview-icon-01' },
  {
    id: 'manage',
    label: 'Manage',
    icon: 'manage-icon',
    route: 'event-home.manage.event-info',
    submenu: [
      {
        id: 'event-info',
        label: 'Event Info',
        icon: 'event-info-icon',
        route: 'event-home.manage.event-info',
      },
      { id: 'team', label: 'Team', icon: 'team-icon', route: 'event-home.manage.team' },
      {
        id: 'agenda',
        label: 'Agenda',
        icon: 'agenda-icon',
        route: 'event-home.manage.agenda',
      },
      {
        id: 'speakers',
        label: 'Speakers',
        icon: 'speakers-icon',
        route: 'event-home.manage.speakers',
      },
      {
        id: 'sponsors',
        label: 'Sponsors',
        icon: 'sponsors-icon',
        route: 'event-home.manage.sponsors',
      },
      {
        id: 'promote',
        label: 'Promote',
        icon: 'promote-icon',
        route: 'event-home.manage.promote',
      },
      {
        id: 'engagement',
        label: 'Engagement',
        icon: 'engagement-icon',
        route: 'event-home.manage.engagement',
      },
      {
        id: 'event-library',
        label: 'Event Library',
        icon: 'event-library-icon',
        route: 'event-home.manage.event-library',
      },
      {
        id: 'custom-forms',
        label: 'Custom Forms',
        icon: 'form-responses-icon',
        route: 'event-home.manage.custom-forms',
      },
      { id: 'onair', label: 'OnAir', icon: 'onair-icon', route: 'event-home.manage.onair' },
    ],
  },
  { id: 'registrations', label: 'Registrations', icon: 'registration-icon' },
  { id: 'exhibitors', label: 'Exhibitors', icon: 'expo-icon' },
  { id: 'abstract', label: 'Abstract', icon: 'user-education-icon' },
  { id: 'design', label: 'Design', icon: 'design-icon' },
  { id: 'communicate', label: 'Communicate', icon: 'communicate-icon' },
  { id: 'reports', label: 'Reports', icon: 'report-icon-01' },
  { id: 'event-day', label: 'Event Day', icon: 'event-day-icon' },
  { id: 'settings', label: 'Settings', icon: 'settings-icon' },
];

export const portalSettingsNavItems = [
  { id: 'general', label: 'General', route: 'home.portal-settings' },
  { id: 'branding', label: 'Branding' },
  { id: 'portal-members', label: 'Portal Members' },
  { id: 'payments-and-tax', label: 'Payments and Tax' },
  { id: 'data-privacy', label: 'Data Privacy' },
  { id: 'webhooks', label: 'Webhooks' },
  { id: 'integrations', label: 'Integrations' },
  { id: 'spaces', label: 'Spaces' },
  { id: 'automation', label: 'Automation' },
  { id: 'library', label: 'Library' },
];
