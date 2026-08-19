import Route from '@ember/routing/route';
import { eventNavItems } from 'ulx-lab/mocks/page-chrome';

function sectionForPageId(pageId) {
  const manageItem = eventNavItems.find((item) => item.id === 'manage');
  return manageItem?.submenu?.find((item) => item.id === pageId);
}

export default class EventPageRoute extends Route {
  model(params) {
    const eventChrome = this.modelFor('event');
    const section = sectionForPageId(params.page_id);

    return {
      ...eventChrome,
      section: section ?? { id: params.page_id, label: params.page_id },
    };
  }
}
