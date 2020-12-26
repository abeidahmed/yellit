import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['hiddenElement', 'shownElement'];

  connect() {
    if (this.pageIsTurboPreview) {
      this.hide();
    }
  }

  show() {
    this.hiddenElementTarget.removeAttribute('hidden');
    this.shownElementTarget.setAttribute('hidden', '');
  }

  hide() {
    this.hiddenElementTarget.setAttribute('hidden', '');
    this.shownElementTarget.removeAttribute('hidden');
  }
}
