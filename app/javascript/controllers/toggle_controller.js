import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['content'];
  static classes = ['toggle'];
  static values = {
    attribute: String,
  };

  connect() {
    if (this.pageIsTurboPreview) {
      this.hide();
    }
  }

  show() {
    this.addToggleClass();
    this.addToggleAttribute();
  }

  toggle() {
    this.toggleToggleClass();
    this.toggleAttribute();
  }

  hide() {
    this.resetToggleClass();
    this.resetHiddenAttribute();
  }

  onOutsideClick(e) {
    if (!this.element.contains(e.target)) {
      this.hide();
    }
  }

  addToggleClass() {
    if (this.hasToggleClass) {
      this.contentTarget.classList.add(this.toggleClass);
    }
  }

  addToggleAttribute() {
    if (this.hasAttributeValue) {
      this.contentTarget.removeAttribute(this.attributeValue);
    }
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
