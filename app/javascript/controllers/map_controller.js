import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
// import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static targets = ["list", "map"]

  static values = {
    apiKey: String,
    markers: Array,
    redimage: String,
    blueimage: String,
    query: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/dark-v10"
    })

    if (this.hasListTarget) {
      this.showCurrentPosition()
    } else {
      this.#addMarkersToMap();
      this.#fitMapToMarkers();
    }
  }

  showCurrentPosition() {
    navigator.geolocation.getCurrentPosition((position) => {
      const { latitude, longitude } = position.coords;
      const marker = { lat: latitude, lng: longitude, isCurrent: true };
      this.markersValue = [...this.markersValue, marker];
      this.#addMarkersToMap();
      this.#fitMapToMarkers();

      fetch(
        `/bookings?lat=${marker.lat}&lng=${marker.lng}&query=${this.queryValue}`,
        {headers: {"Accept": "text/plain"}}
      )
        .then(response => response.text())
        .then((data) => {
          this.listTarget.outerHTML = data
        })
    });
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const element = document.createElement('div');
      element.className = 'custom-marker';
      element.style.backgroundImage = `url(${marker.isCurrent ? this.redimageValue : this.blueimageValue})`;

      if (this.hasListTarget) {
        element.addEventListener('click', (e) => {
          const parking = document.querySelector(`#parking-${marker.parkingId}`)
          if (parking) {
            document.querySelectorAll('.booking-card').forEach((card) => {
              card.classList.add('d-none');
            })
            parking.classList.remove('d-none')
            document.querySelector('.booking-cards-container').classList.add('booking-card-selected')
          }
        })
      }
      new mapboxgl
        .Marker({ element })
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(
      bounds,
      {
        padding: { top: 50, bottom: 300, left: 70, right: 70 },
        maxZoom: 15,
        duration: 0
      }
    )
  }
}
