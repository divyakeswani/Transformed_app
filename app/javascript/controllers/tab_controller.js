import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["all", "accepted", "pending", "info"]

  connect() {
    console.log('connected')
    this.allTargets.forEach(el => {
      el.hidden = true
    });
    this.acceptedTargets.forEach(el => {
      el.hidden = true
    });
    this.pendingTargets.forEach(el => {
      el.hidden = true
    });
  }

  allShow(){
    this.allTargets.forEach(el => {
      el.hidden = false
    });
    this.acceptedTargets.forEach(el => {
      el.hidden = true
    });
    this.pendingTargets.forEach(el => {
      el.hidden = true
    });
  }

  acceptedShow(){
    this.acceptedTargets.forEach(el => {
      el.hidden = false
    });
    this.allTargets.forEach(el => {
      el.hidden = true
    });
    this.pendingTargets.forEach(el => {
      el.hidden = true
    });
  }

  pendingShow(){
    this.pendingTargets.forEach(el => {
      el.hidden = false
    });
    this.acceptedTargets.forEach(el => {
      el.hidden = true
    });
    this.allTargets.forEach(el => {
      el.hidden = true
    });
  }

  infoShow(){
    console.log('hello')
    this.infoTargets.forEach(el => {
      debugger
      el.hidden = false
    });
    debugger
  }
}
