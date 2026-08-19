export const createEventMock = {
  eventType: 'in-person',
  eventName: '',
  category: 'OTHERS',
  startDate: new Date(2026, 8, 16),
  endDate: new Date(2026, 8, 16),
  startTime: '0800',
  endTime: '1700',
  language: 'en',
};

export const eventCategories = [
  { label: 'Others', value: 'OTHERS' },
  { label: 'Conference', value: 'CONFERENCE' },
  { label: 'Workshop', value: 'WORKSHOP' },
  { label: 'Meetup', value: 'MEETUP' },
];

export const sourceLanguages = [
  { label: 'English', value: 'en', dataQa: 'sourcelanguage-English' },
  { label: 'Spanish', value: 'es', dataQa: 'sourcelanguage-Spanish' },
  { label: 'French', value: 'fr', dataQa: 'sourcelanguage-French' },
  { label: 'German', value: 'de', dataQa: 'sourcelanguage-German' },
  { label: 'Chinese', value: 'zh', dataQa: 'sourcelanguage-Chinese' },
];
