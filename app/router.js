import EmberRouter from '@ember/routing/router';
import config from 'ulx-lab/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('home', function () {
    this.route('portal-settings');
  });
  this.route('event-home', { path: 'home/event-home' }, function () {
    this.route('manage', function () {
      this.route('event-info');
      this.route('team');
      this.route('agenda');
      this.route('speakers');
      this.route('sponsors');
      this.route('promote');
      this.route('engagement');
      this.route('event-library');
      this.route('custom-forms');
      this.route('onair');
    });
  });
  this.route('screens', function () {
    this.route('ticket-class-form');
    this.route('create-event');
    this.route('ticket-list');
  });
});
