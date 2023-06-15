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
    flagimage: String,
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
      const marker = { lat: latitude, lng: longitude, isCurrent: 1 };
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
    this.#geocodeAddress(this.queryValue);
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const element = document.createElement('div');
      element.className = 'custom-marker';
      // element.style.backgroundImage = `url(${marker.isCurrent ? this.redimageValue : this.blueimageValue})`;
      if (marker.isCurrent === 1) {
        element.style.backgroundImage = `url(${this.redimageValue})`;
      } else if (marker.isCurrent === 2) {
        element.style.backgroundImage = `url(${this.flagimageValue})`;
      } else {
        element.style.backgroundImage = `url(${this.blueimageValue})`;
      }

      if (this.hasListTarget){
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

  // Fonction pour convertir une adresse en latitude et longitude
  #geocodeAddress(address) {
    var geocodingUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/" + encodeURIComponent(address) + ".json?access_token=" + this.apiKeyValue;

    // Requête HTTP GET pour obtenir les coordonnées géographiques
    fetch(geocodingUrl)
      .then(response => response.json())
      .then(data => {
        if (data.features && data.features.length > 0) {
          // Récupération de la première caractéristique (résultat) retournée
          var feature = data.features[0];
          // Récupération de la latitude et longitude
          var latitude = feature.center[1];
          var longitude = feature.center[0];
          console.log("Latitude : " + latitude);
          console.log("Longitude : " + longitude);
          const marker = { lat: latitude, lng: longitude, isCurrent: 2 };
          this.markersValue = [...this.markersValue, marker];
          this.#addMarkersToMap();
          this.#fitMapToMarkers();
        }
      })
  }
}
