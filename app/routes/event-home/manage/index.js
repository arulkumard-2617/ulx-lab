import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class EventHomeManageIndexRoute extends Route {
  @service router;

  redirect() {
    this.router.replaceWith('event-home.manage.event-info');
  }
}
