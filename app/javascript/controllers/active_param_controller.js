import qs from 'query-string';
import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['list'];

  connect() {
    this.setActive();
  }

  setActive() {
    const q = qs.parse(location.search);

    this.listTargets.forEach((t) => {
      if (!t.value.length && !Object.keys(q).length) {
        t.setAttribute('aria-checked', true);
      } else if (t.value === q.role) {
        t.setAttribute('aria-checked', true);
      } else {
        t.setAttribute('aria-checked', false);
      }
    });
  }
}
