import qs from 'query-string';
import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static values = {
    url: String,
    key: String,
    target: String,
  };

  observeField(e) {
    const url = this.appendQuery({ url: this.urlValue, value: e.target.value });

    const browserUrl = this.appendQuery({ url: window.location.href, value: e.target.value });
    window.history.pushState({}, '', browserUrl);

    this.makeRequest(url);
  }

  filter(e) {
    const url = this.appendQuery({ url: this.urlValue, value: e.target.value });

    const browserUrl = this.appendQuery({ url: window.location.href, value: e.target.value });
    window.history.pushState({}, '', browserUrl);

    this.makeRequest(url, 0);
  }

  makeRequest(url, delay = 500) {
    if (this.timeoutId) clearTimeout(this.timeoutId);

    this.timeoutId = setTimeout(async () => {
      const res = await fetch(url);
      const data = await res.text();

      document.getElementById(this.targetValue).innerHTML = data;
    }, delay);
  }

  appendQuery({ url, value }) {
    const q = qs.parse(location.search);
    return qs.stringifyUrl(
      {
        url,
        query: {
          ...q,
          [this.keyValue]: value,
        },
      },
      { skipEmptyString: true }
    );
  }
}
