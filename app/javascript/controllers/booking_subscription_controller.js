import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="booking-subscription"
export default class extends Controller {
  static values = { bookingId: Number }
  connect() {
    console.log(`Réserve cette place numéro ${this.bookingIdValue}.`)
  }
}
