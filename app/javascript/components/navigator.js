var options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
};

function success(pos) {
  var crd = pos.coords;
  document.querySelector("#lat_query").value = crd.latitude
  document.querySelector("#long_query").value = crd.longitude
}

function error(err) {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}

const initNavigator = function () {
  navigator.geolocation.getCurrentPosition(success, error, options);
}

export { initNavigator }
