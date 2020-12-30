import ApplicationController from '../application_controller';

export default class extends ApplicationController {
  static targets = ['publishBtn', 'checkbox', 'dateTime'];

  connect() {
    if (!this.pageIsTurboPreview) {
      this.updateStatus();
    }
  }

  updateStatus() {
    this.updateDateTimeField();
    this.changeBtnText();
  }

  changeBtnText() {
    this.publishBtnTargets.forEach((btn) => {
      if (this.checkboxTarget.checked) {
        return (btn.innerText = 'Save draft');
      }

      btn.innerText = 'Publish post';
    });
  }

  updateDateTimeField() {
    if (this.checkboxTarget.checked) {
      return this.dateTimeTarget.setAttribute('hidden', '');
    }

    this.dateTimeTarget.removeAttribute('hidden');
  }
}
