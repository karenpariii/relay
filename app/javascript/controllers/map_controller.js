import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"


// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    redimage: String,
    blueimage: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/dark-v10"
    })



    // this.map.on('click', () => {
    //   document.querySelectorAll('.card-border-layer').forEach((card) => {
    //     console.log(card)
    //     card.classList.remove('d-none');
    //   })
    // })
    this.showCurrentPosition()
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
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
        },
      );
    }


  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const element = document.createElement('div');
      element.className = 'custom-marker';
      element.style.backgroundImage = `url(${marker.isCurrent ? this.redimageValue : this.blueimageValue})`;
      element.dataset.parkingId = marker.parkingId
      element.addEventListener('click', (e) => {
        document.querySelectorAll('.card-border-layer').forEach((card) => {
          card.classList.add('d-none');
        })
        document.querySelector(`#parking-${e.currentTarget.dataset.parkingId}`).classList.remove('d-none')
      })
      new mapboxgl.Marker({ element })
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }


}
