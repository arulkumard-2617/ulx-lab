import EmberRouter from '@ember/routing/router';
import config from 'ulx-lab/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('home', { path: '/' }, function () {
    this.route('event-listing', { path: '' });
  });
  this.route('event', { path: 'event/:event_id' }, function () {
    this.route('page', { path: ':page_id' });
  });
  this.route('screens', function () {
    this.route('ticket-class-form');
    this.route('create-event');
    this.route('ticket-list');
  });
});
