import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["info"]

  connect() {
    console.log('connected')
  }

  infoShow(){
    console.log('info')
    this.infoTargets.forEach(el => {
      el.hidden = false
    });
  }
}
