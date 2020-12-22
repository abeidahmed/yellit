import Rails from '@rails/ujs';
import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['form', 'result'];

  populateResult(e) {
    const data = e.detail[0].body.innerHTML;
    this.resultTarget.innerHTML = data;
  }

  performSearch(e) {
    this.updateQueryParam(e.target.value);

    if (this.timeoutId) clearTimeout(this.timeoutId);
    this.timeoutId = setTimeout(() => {
      Rails.fire(this.formTarget, 'submit');
    }, 500);
  }

  updateQueryParam(value) {
    const url = new URL(window.location);
    url.searchParams.set('query', value);
    window.history.pushState({}, '', url);
  }
}
