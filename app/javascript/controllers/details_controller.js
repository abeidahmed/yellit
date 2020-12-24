import ApplicationController from './application_controller';

export default class extends ApplicationController {
  connect() {
    if (this.pageIsTurboPreview) {
      this.hide();
    }
  }

  hide() {
    this.element.removeAttribute('open');
  }
}
