import Route from '@ember/routing/route';

export default class HomeEventListingRoute extends Route {
  model() {
    return this.modelFor('home');
  }
}
