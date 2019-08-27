import "bootstrap";

const input = document.querySelector('.form-inputs');
console.log(input)
input.addEventListener('change', (event) => {
  const startDate = document.getElementById('booking_start_date');
  const endDate = document.getElementById('booking_end_date');
  console.log(startDate)
  console.log(endDate)
});

