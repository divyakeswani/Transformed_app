import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = ["bar"]

  connect() {
    console.log('chart')
  }

  chartShow(){
    console.log('chartShow')
    this.barTargets.forEach(el => {
      console.log('hii')
      el.hidden = true
    });
  }
}