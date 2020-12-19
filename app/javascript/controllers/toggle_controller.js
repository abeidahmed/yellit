import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['content'];
  static classes = ['toggle'];

  connect() {
    if (this.pageIsTurbolinksPreview) {
      this.contentTarget.classList.add(this.toggleClass);
    }
  }

  toggle() {
    this.contentTarget.classList.toggle(this.toggleClass);
  }
}
