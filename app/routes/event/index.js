import Route from '@ember/routing/route';

export default class EventIndexRoute extends Route {
  model() {
    return this.modelFor('event');
  }
}
