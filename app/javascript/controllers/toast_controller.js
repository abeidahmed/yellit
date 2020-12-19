import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['content'];

  connect() {
    if (!this.pageIsTurbolinksPreview) {
      this.contentTarget.classList.add('Toast--animateIn');

      setTimeout(() => {
        this.hide();
      }, 4000);
    }
  }

  hide() {
    this.contentTarget.classList.replace('Toast--animateIn', 'Toast--animateOut');
  }
}
