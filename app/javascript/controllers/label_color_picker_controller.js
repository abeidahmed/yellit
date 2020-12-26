import ApplicationController from './application_controller';
import Chroma from '../lib/chroma';

export default class extends ApplicationController {
  static targets = ['input', 'sideEffect'];

  connect() {
    this.chroma = new Chroma({
      input: this.inputTarget,
      defaultColor: this.inputTarget.value,
    });

    this.observe();
  }

  observe() {
    this.publishSideEffect(this.inputTarget.value);
  }

  pickColor(e) {
    const chosenColor = e.target.value;
    this.inputTarget.value = chosenColor;

    this.publishSideEffect(chosenColor);
  }

  publishSideEffect(color) {
    const palette = this.chroma.generatePalette(color);
    if (!palette) return;

    const { primary, accent } = palette;
    this.sideEffectTarget.style.backgroundColor = primary;
    this.sideEffectTarget.style.color = accent;
  }
}
