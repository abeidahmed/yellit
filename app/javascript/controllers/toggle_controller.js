import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['content'];
  static classes = ['toggle'];
  static values = {
    attribute: String,
  };

  connect() {
    if (this.pageIsTurbolinksPreview) {
      this.hide();
    }
  }

  toggle() {
    this.toggleToggleClass();
    this.toggleAttribute();
  }

  toggleToggleClass() {
    if (this.hasToggleClass) {
      this.contentTarget.classList.toggle(this.toggleClass);
    }
  }

  toggleAttribute() {
    if (this.hasAttributeValue) {
      this.contentTarget.toggleAttribute(this.attributeValue);
    }
  }

  hide() {
    this.resetToggleClass();
    this.resetHiddenAttribute();
  }

  resetToggleClass() {
    if (this.hasToggleClass) {
      this.contentTarget.classList.add(this.toggleClass);
    }
  }

  resetHiddenAttribute() {
    if (this.hasAttributeValue) {
      this.contentTarget.setAttribute(this.attributeValue, '');
    }
  }
}
