import Rails from '@rails/ujs';
import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['form', 'result'];

  populateResult(e) {
    const data = e.detail[0].body.innerHTML;
    this.resultTarget.innerHTML = data;
  }

  performSearch(e) {
    Rails.fire(this.formTarget, 'submit');
  }
}
