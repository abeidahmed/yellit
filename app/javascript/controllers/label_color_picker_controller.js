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

  observe(e) {
    if (typeof e !== 'undefined') {
      const palette = this.chroma.generatePalette(e.target.value);
      this.inputTarget.value = e.target.value;
      this.publishSideEffect(palette);
    }
  }

  publishSideEffect(palette) {
    if (!palette) return;

    const { primary, accent } = palette;
    this.sideEffectTarget.style.backgroundColor = primary;
    this.sideEffectTarget.style.color = accent;
  }
}
