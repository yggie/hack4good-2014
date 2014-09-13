// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var posts = [],
    markers = [],
    map,
    lastCircle;

function initialize() {
  var mapCanvas = document.getElementById('map_canvas');

  var mapOptions = {
    center: new google.maps.LatLng(70.8, -1.3),
    zoom: 13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(mapCanvas, mapOptions)

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function (position) {
      initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
      map.setCenter(initialLocation);
    });
  }
  google.maps.event.addListener(map, 'click', function(event) {
    var options = {
      strokeColor: '#FF0000',
      strokeOpacity: 0.7,
      strokeWeight: 2,
      fillColor: '#FF0000',
      fillOpacity: 0.35,
      map: map,
      center: event.latLng,
      radius: 8000
    };

    if(lastCircle != null) {
      lastCircle.setMap(null);
    }

    lastCircle = new google.maps.Circle(options);
  });
}

google.maps.event.addDomListener(window, 'load', initialize);



function refreshMap() {
  while (markers.length) {
    markers.pop().map = null;
  }

  function generateInfoWindowContent(post) {
    return '<div id="content"><img src="' + post.photo.thumbnail + '"></div>'
  }

  var info = new google.maps.InfoWindow({
    content: '<div id="content">'+
      '<img src=""></div>',
    maxWidth: 400,
    maxHeight: 40
  });

  for (var i = 0; i < posts.length; i++) {
    var post = posts[i];

    var latlng = new google.maps.LatLng(post.latitude, post.longitude);

    var m = new google.maps.Marker({
      position: latlng,
      map: map,
      title: 'empty string',
    });

    google.maps.event.addListener(m, 'click', (function (infowindow, marker, post) {
      return function () {
        infowindow.setContent(generateInfoWindowContent(post));
        infowindow.open(map, this);
      };
    })(info, m, post));

    markers.push(m);
  }
}

$(document).on('ready', function () {

  $('#refresh').click(function () {
    $.ajax({
      url: 'posts/search',
      data: {
        latitude: 50.8,
        longitude: -1.3,
        miles: 69.0,
      },
      success: function (data) {
        posts = data;
        refreshMap();
      },
    });
  });

  $('#refresh').click();

  $(".mobile-menu").click( function() {
    $(this).closest(".side-container").toggleClass("mobile-show", 500);
    $(this).find(".fa").switchClass("fa-caret-square-o-down", "fa-caret-square-o-up", 500);
  });

  $(".side-nav li").click( function() {
    $(this).find(".nav").toggle(500);
  });
});
