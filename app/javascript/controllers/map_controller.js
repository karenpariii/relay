import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"


// Connects to data-controller="map"
export default class extends Controller {
  static targets = ["list", "map"]

  static values = {
    apiKey: String,
    markers: Array,
    redimage: String,
    blueimage: String
  }
   connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/dark-v10"
    })

    // this.map.on('click', () => {
    //   document.querySelectorAll('.card-border-layer').forEach((card) => {
    //     console.log(card)
    //     card.classList.remove('d-none');
    //   })
    // })
    if (this.hasListTarget){
      this.showCurrentPosition()
    } else {
      this.#addMarkersToMap();
      this.#fitMapToMarkers();
    }
    }

      showCurrentPosition() {
          navigator.geolocation.getCurrentPosition(
            (position) => {
              const { latitude, longitude } = position.coords;
              const marker = { lat: latitude, lng: longitude, isCurrent: true };
              this.markersValue = [...this.markersValue, marker];
              this.#addMarkersToMap();
              this.#fitMapToMarkers();
              console.log("Position OK")
              fetch(`/bookings?lat=${marker.lat}&lng=${marker.lng}`, {headers: {"Accept": "text/plain"}})
              .then(response => response.text())
              .then((data) => {
                this.listTarget.outerHTML = data
              })
            },
          );
        }


  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const element = document.createElement('div');
      element.className = 'custom-marker';
      element.style.backgroundImage = `url(${marker.isCurrent ? this.redimageValue : this.blueimageValue})`;
      if (this.hasListTarget){
        element.dataset.parkingId = marker.parkingId
        element.addEventListener('click', (e) => {
          document.querySelectorAll('.card-border-layer').forEach((card) => {
            card.classList.add('d-none');
          })
          document.querySelector(`#parking-${e.currentTarget.dataset.parkingId}`).classList.remove('d-none')
        })
      }
      new mapboxgl.Marker({ element })
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: { top: 0, bottom: 300, left: 70, right: 70 }, maxZoom: 15, duration: 0 })
  }


}
