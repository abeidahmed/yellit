import ApplicationController from './application_controller';

export default class extends ApplicationController {
  connect() {
    if (this.pageIsTurbolinksPreview) {
      this.hide();
    }
  }

  hide() {
    this.element.removeAttribute('open');
  }
}
