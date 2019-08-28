
import 'bootstrap';
const inputs = document.querySelectorAll('.form-inputs');
inputs.forEach((input)=>{
  input.addEventListener('change', (event) => {
    const startDate = document.getElementById('booking_start_date').value;
    const endDate = document.getElementById('booking_end_date').value;
    if (endDate !== '' && startDate !== '') {
      
import { toggleDateInputs } from '../components/booking';
toggleDateInputs()

import 'mapbox-gl/dist/mapbox-gl.css';
// internal imports
import { initMapbox } from '../plugins/init_mapbox';

initMapbox();
