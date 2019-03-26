import flatpickr from 'flatpickr';

  const toggleDateInputs = function() {
    // id added to the form inputs
   const startDateinput = document.getElementById('booking_start_date');
   const endDateinput = document.getElementById('booking_end_date');

    if (startDateinput && endDateinput) {

      // given by flatpicker - doc
      flatpickr(startDateinput, {
        minDate: 'today',
        dateFormat: 'd-m-Y',

        onChange: function(_, selectedDate) {
          if (selectedDate === '') {
            return endDateinput.disabled = true;
          }
          endDateCalendar.set('minDate', selectedDate);
          endDateinput.disabled = false;
       }
   });
     const endDateCalendar =
       flatpickr(endDateinput, {
         dateFormat: 'd-m-Y',
       });
   }
 };

export { toggleDateInputs }
