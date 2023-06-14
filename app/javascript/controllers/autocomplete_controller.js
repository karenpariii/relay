import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";


// Connects to data-controller="autocomplete"
export default class extends Controller {
  static targets = ["input", "inputaddress"];
  static values = { apiKey: String }
  connect() {
    const geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      countries: 'fr',
      types: "country,region,place,postcode,locality,neighborhood,address"
    });

    geocoder.addTo(this.inputTarget);

    geocoder.on("result", (event) => {
      this.inputaddressTarget.value = event.result.text;
    });

    geocoder.on("clear", () => {
      this.inputTarget.value = "";
    });
  }
}
