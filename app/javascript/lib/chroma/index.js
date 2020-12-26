import { makePalette } from './utils/make_palette';

export default class Chroma {
  constructor({ input, defaultColor }) {
    this.input = input;
    this.defaultColor = defaultColor;
    this.loadDefaultColor();
    this.appendPoundSymbol();
  }

  loadDefaultColor() {
    this.input.value = this.defaultColor;
  }

  appendPoundSymbol() {
    this.input.addEventListener('input', () => {
      if (this.input.value.charAt(0) !== '#') {
        this.input.value = `#${this.input.value}`;
      }
    });
  }

  generatePalette(value) {
    return makePalette(value || this.defaultColor);
  }
}
