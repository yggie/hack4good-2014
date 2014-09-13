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
    map;

function initialize() {
  var mapCanvas = document.getElementById('map_canvas');

  var mapOptions = {
    center: new google.maps.LatLng(50.8, -1.3),
    zoom: 11,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(mapCanvas, mapOptions)

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function (position) {
      initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
      map.setCenter(initialLocation);
    });
  }
}

google.maps.event.addDomListener(window, 'load', initialize);

function refreshMap() {
  while (markers.length) {
    markers.pop().map = null;
  }

  for (var i = 0; i < posts.length; i++) {
    var post = posts[i];

    var latlng = new google.maps.LatLng(post.latitude, post.longitude);

    var m = new google.maps.Marker({
      position: latlng,
      map: map,
      title: 'empty string',
    });

    var info = new google.maps.InfoWindow({
      content: '<div id="content">'+
        '<img src="' + post.photo.thumbnail + '"></div>',
      maxWidth: 400,
      maxHeight: 40
    });

    google.maps.event.addListener(m, 'click', function() {
      info.open(map,m);
    });

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
