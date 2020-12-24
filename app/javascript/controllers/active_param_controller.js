import qs from 'query-string';
import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['list'];
  static values = {
    key: String,
  };

  connect() {
    this.setActive();
  }

  setActive() {
    const q = qs.parse(location.search);

    this.listTargets.forEach((t) => {
      if (!t.value.length && (!Object.keys(q).length || !q[this.keyValue])) {
        t.setAttribute('aria-checked', true);
      } else if (t.value === q[this.keyValue]) {
        t.setAttribute('aria-checked', true);
      } else {
        t.setAttribute('aria-checked', false);
      }
    });
  }
}
