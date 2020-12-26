import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['bind'];
  static values = { default: String };

  type(e) {
    if (!e.target.value) {
      return this.setTyper(this.defaultValue);
    }

    this.setTyper(e.target.value);
  }

  setTyper(value) {
    this.bindTarget.innerText = value;
  }
}
