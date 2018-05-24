mapboxgl.accessToken = 'pk.eyJ1IjoibGlsd2lsbGlmbyIsImEiOiJjamhqc3MxejMybjl4M2NtN3pyODB6a3FjIn0.SRm-mNE5-hpImM_QM7WQFA';
var map = new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/lilwillifo/cjhjyrj7e332m2socy4h6hcya',
  center: [-105.58887, 39.2501],
  zoom: 5.8
});

map.on('load', function () {

  map.addSource('district1', {
    type: 'geojson',
    data: 'https://raw.githubusercontent.com/unitedstates/districts/gh-pages/cds/2016/CO-1/shape.geojson'
  });

  map.addSource('district2', {
    type: 'geojson',
    data: 'https://raw.githubusercontent.com/unitedstates/districts/gh-pages/cds/2016/CO-2/shape.geojson'
  });

  map.addSource('district3', {
    type: 'geojson',
    data: 'https://raw.githubusercontent.com/unitedstates/districts/gh-pages/cds/2016/CO-3/shape.geojson'
  });

  map.addSource('district4', {
    type: 'geojson',
    data: 'https://raw.githubusercontent.com/unitedstates/districts/gh-pages/cds/2016/CO-4/shape.geojson'
  });

  map.addSource('district5', {
    type: 'geojson',
    data: 'https://raw.githubusercontent.com/unitedstates/districts/gh-pages/cds/2016/CO-5/shape.geojson'
  });

  map.addSource('district6', {
    type: 'geojson',
    data: 'https://raw.githubusercontent.com/unitedstates/districts/gh-pages/cds/2016/CO-6/shape.geojson'
  });

  map.addSource('district7', {
    type: 'geojson',
    data: 'https://raw.githubusercontent.com/unitedstates/districts/gh-pages/cds/2016/CO-7/shape.geojson'
  });

    map.addLayer({
        'id': 'district1',
        'type': 'fill',
        'source': 'district1',
        'layout': {},
        'paint': {
            'fill-color': '#FB4D3D',
            'fill-opacity': 0.3
        }
    });

    map.addLayer({
        'id': 'district2',
        'type': 'fill',
        'source': 'district2',
        'layout': {},
        'paint': {
            'fill-color': '#419D78',
            'fill-opacity': 0.3
        }
    });

    map.addLayer({
        'id': 'district3',
        'type': 'fill',
        'source': 'district3',
        'layout': {},
        'paint': {
            'fill-color': '#C04ABC',
            'fill-opacity': 0.3
        }
    });

    map.addLayer({
        'id': 'district4',
        'type': 'fill',
        'source': 'district4',
        'layout': {},
        'paint': {
            'fill-color': '#2D3047',
            'fill-opacity': 0.3
        }
    });

    map.addLayer({
        'id': 'district5',
        'type': 'fill',
        'source': 'district5',
        'layout': {},
        'paint': {
            'fill-color': '#FC60A8',
            'fill-opacity': 0.4
        }
    });

    map.addLayer({
        'id': 'district6',
        'type': 'fill',
        'source': 'district6',
        'layout': {},
        'paint': {
            'fill-color': '#345995',
            'fill-opacity': 0.3
        }
    });

    map.addLayer({
        'id': 'district7',
        'type': 'fill',
        'source': 'district7',
        'layout': {},
        'paint': {
            'fill-color': '#EAC435',
            'fill-opacity': 0.3
        }
    });

  });

  // When the user moves their mouse over the states-fill layer, we'll update the filter in
  // the state-fills-hover layer to only show the matching state, thus making a hover effect.
  map.on("mousemove", "district3", function(e) {
    map.addLayer({
      "id": "district3-hover",
      "type": "fill",
      "source": "district3",
      "layout": {},
      "paint": {
          "fill-color": "#C04ABC",
          "fill-opacity": 1
        },
    });
  });
