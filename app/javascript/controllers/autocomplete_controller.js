import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";


// Connects to data-controller="autocomplete"
export default class extends Controller {
  static targets = ["input"];
  static values = { apiKey: String }
  connect() {
    const geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address"
    });

    geocoder.on("result", (event) => {
      this.inputTarget.value = event.result.text;
    });

    // geocoder.on("clear", () => {
    //   this.inputTarget.value = "";
    // });

    geocoder.addTo(this.inputTarget);
  }
}
