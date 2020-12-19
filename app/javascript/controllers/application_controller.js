import { Controller } from 'stimulus';

export default class ApplicationController extends Controller {
  get pageIsTurbolinksPreview() {
    return document.documentElement.hasAttribute('data-turbolinks-preview');
  }
}
