import Route from '@ember/routing/route';

export default class EventHomeManageEventInfoRoute extends Route {
  model() {
    return this.modelFor('event-home');
  }
}
