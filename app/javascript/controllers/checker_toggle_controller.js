import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['checkbox', 'content'];

  connect() {
    this.hideContent();
  }

  hideContent() {
    const isChecked = this.checkboxTarget.checked;

    if (isChecked) {
      return this.contentTarget.setAttribute('hidden', '');
    }

    this.contentTarget.removeAttribute('hidden');
  }
}
