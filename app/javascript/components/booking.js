

import flatpickr from "flatpickr";
require("flatpickr/dist/themes/dark.css");

const toggleDateInputs = function() {
  if (document.querySelector('.widget-content')) {
  const unavailableDates = JSON.parse(document.querySelector('.widget-content').dataset.unavailable)
  flatpickr('#booking_start_date', {
    minDate: 'today',
    mode: "range",
    disable: unavailableDates,
    onChange: function(selectedDates, dateStr) {
      let range = dateStr
      const splited = range.split('to');
      const startDate = Date.parse(splited[0]);
      const endDate = Date.parse(splited[1]);
      const days = (startDate - endDate)/86400000
      const roundedDay = Math.abs(days) + 1
      const dailyPrice = document.querySelector('#total-price').dataset.price
      const totalPrice = parseInt(dailyPrice) * roundedDay
      document.querySelector('#total-price').innerText = "$" + totalPrice
    }
   });
};
};


export { toggleDateInputs }
