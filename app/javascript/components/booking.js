

import flatpickr from "flatpickr";
require("flatpickr/dist/themes/dark.css");

// const inputs = document.querySelectorAll('.form-inputs');
// inputs.forEach((input)=>{
//   input.addEventListener('change', (event) => {
//     const startDate = document.getElementById('booking_start_date').value;
//     const endDate = document.getElementById('booking_end_date').value;
//     if (endDate !== '' && startDate !== '') {

//     const days = ((Date.parse(startDate) - Date.parse(endDate))/86400000)
//     const roundedDay = Math.abs(days) + 1
//     const dailyPrice = document.querySelector('#total-price').dataset.price
//     const totalPrice = parseInt(dailyPrice) * roundedDay
//     document.querySelector('#total-price').innerText = "$" + totalPrice
//     }
//   });
// });

const toggleDateInputs = function() {
  const inputs = document.querySelectorAll('.form-inputs');
  flatpickr('#booking_start_date', {
    minDate: 'today'
   });
  flatpickr('#booking_end_date', {
    minDate: 'today'
  });

inputs.forEach((input)=>{
  input.addEventListener('change', (event) => {
    const startDate = document.getElementById('booking_start_date').value;
    const endDate = document.getElementById('booking_end_date').value;
    if (endDate !== '' && startDate !== '') {

    const days = ((Date.parse(startDate) - Date.parse(endDate))/86400000)
    const roundedDay = Math.abs(days) + 1
    const dailyPrice = document.querySelector('#total-price').dataset.price
    const totalPrice = parseInt(dailyPrice) * roundedDay
    document.querySelector('#total-price').innerText = "$" + totalPrice
    }
  });
});
};


export { toggleDateInputs }
