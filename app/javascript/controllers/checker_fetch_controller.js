import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['checkbox', 'publishElement'];

  connect() {
    this.check();
  }

  check() {
    const checkboxId = [];
    this.checkboxTargets.forEach((box) => {
      if (box.checked) {
        checkboxId.push(box.value);
      }
    });

    console.log(checkboxId);
  }
}
