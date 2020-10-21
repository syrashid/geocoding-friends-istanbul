
import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 90, maxZoom: 15, duration: 3000 });
  };

  const addMapToMarkers = (map, markers) => {
      markers.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });
  }

  if (mapElement) { // only build a map if there's a div#map to inject into
    // Generate map on page
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });


    const markers = JSON.parse(mapElement.dataset.markers);
    // Add markers to page
    addMapToMarkers(map, markers);
    fitMapToMarkers(map, markers);
  }
};

export { initMapbox };
