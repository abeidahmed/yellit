import qs from 'query-string';
import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['checkbox', 'publishElement'];
  static values = {
    url: String,
  };

  connect() {
    this.check();
  }

  check() {
    const checkboxId = [];
    this.checkboxTargets.forEach((box) => {
      if (box.checked) {
        checkboxId.push(box.value);
      }
    });

    this.fetchElements(checkboxId);
  }

  async fetchElements(ids) {
    const url = qs.stringifyUrl(
      {
        url: this.urlValue,
        query: {
          element_ids: ids,
        },
      },
      { skipEmptyString: true, arrayFormat: 'bracket' }
    );

    const res = await fetch(url);
    const data = await res.text();

    this.publishElementTarget.innerHTML = data;
  }
}
