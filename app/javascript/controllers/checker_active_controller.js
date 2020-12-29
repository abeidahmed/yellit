import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['checkbox'];

  connect() {
    this.setActive();
  }

  setActive() {
    if (this.checkboxTarget.checked) {
      return this.element.setAttribute('aria-checked', true);
    }

    this.element.setAttribute('aria-checked', false);
  }
}
