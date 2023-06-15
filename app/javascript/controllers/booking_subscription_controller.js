import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { bookingId: Number }

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "BookingChannel", id: this.bookingIdValue },
      { received: data => this.element.outerHTML = data }
    )
    console.log(`Réserve cette place numéro ${this.bookingIdValue}.`)
  }

  disconnect() {
    console.log("Unsubscribed from the booking")
    this.channel.unsubscribe()
  }
}
