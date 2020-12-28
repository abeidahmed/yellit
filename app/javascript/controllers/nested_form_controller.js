import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['insertAbove', 'template'];

  addField() {
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime());
    this.insertAboveTarget.insertAdjacentHTML('beforebegin', content);
  }

  removeField(e) {
    const parentWrapper = e.target.closest('.nested-field');
    const isNewElement = JSON.parse(parentWrapper.dataset.newRecord);

    if (isNewElement) {
      parentWrapper.remove();
    } else {
      parentWrapper.querySelector("input[name*='_destroy']").value = true;
      parentWrapper.setAttribute('hidden', '');
    }
  }
}
