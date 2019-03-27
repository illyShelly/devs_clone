import flatpickr from 'flatpickr';

const numberWithCommas = (number) => {
  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}
// to parse dates from the input fields
const parseDate = (string) => {
  const pattern = /(\d{2})-(\d{2})-(\d{4})/;
  return new Date(string.replace(pattern,'$3-$2-$1'));
}

const updateCosts = function(hours) {
  const costs = document.querySelector('.costs')

  if (costs) {
    // if class costs exist select elements by id
    let hoursElem = document.getElementById('hours');
    let priceElem = document.getElementById('price');
    let totalPriceElem = document.getElementById('total-price');

    let hourRate = JSON.parse(costs.dataset.rate);
    let price = hours * hourRate;
    let totalPrice = price;

    hoursElem.innerHTML = hours;
    priceElem.innerHTML = numberWithCommas(price.toFixed(0));
    // priceElem.innerHTML = price.toFixed(0);
    totalPriceElem.innerHTML = numberWithCommas(totalPrice.toFixed(0));
  }
}


const toggleDateInputs = function() {
  const startDateInput = document.getElementById('booking_start_date');
  const endDateInput = document.getElementById('booking_end_date');
  const costs = document.querySelector('.costs');

  if (startDateInput && endDateInput) {
    const unavailableDates = JSON.parse(document.querySelector('.widget-content').dataset.unavailable)
    // * console.log(unavailableDates);

    flatpickr(startDateInput, {
      minDate: 'today',
      // dateFormat: 'd-m-Y',
      disable: unavailableDates,

    onChange: function(selectedDates, selectedDate) {
      if (selectedDate === '') {
        costs.classList.remove('is-visible');
        endDateInput.disabled = true;
      }
      // adding min number of dates
      let minDate = selectedDates[0];
      minDate.setDate(minDate.getDate() + 1);

      endDateCalendar.set('minDate', minDate);
      endDateInput.disabled = false;
    }
  });
    const endDateCalendar =
      flatpickr(endDateInput, {
        // dateFormat: 'd-m-Y',
        disable: unavailableDates,

        onChange: function(_, selectedDate) {
          if (selectedDate === '') {
            costs.classList.remove('is-visible');
          } else {

            console.log(startDateInput.value);
            // 2019-04-21

            let startDate = parseDate(startDateInput.value);
            console.log(startDate);
            // Sun Apr 21 2019 02:00:00 GMT+0200 (Central European Summer Time)

            let endDate = parseDate(endDateInput.value);

            // ceil -> rounded to nearest integer; (24h/d, 1h -> 60min * 60s, 1s -> 1000ms)
            let hours = Math.round((endDate - startDate) / (1000 * 3600 * 24)  * 6);
            updateCosts(hours);
            costs.classList.add('is-visible');
          }
        },


      });
  }
};

export { toggleDateInputs }

// *
// 5) [{…}, {…}, {…}, {…}, {…}]0:
// {from: "2019-03-27", to: "2019-03-27"}
// 0:
// from: "2019-03-27"
// to: "2019-03-27"
// 1: {from: "2019-04-02", to: "2019-04-04"}
// 2: {from: "2019-03-28", to: "2019-03-29"}
// 3: {from: "2019-03-30", to: "2019-03-31"}
// 4: {from: "2019-04-05", to: "2019-04-06"}
// length: 5__proto__: Array(0)

// PREVIOUS CODE
// const toggleDateInputs = function() {
//    const startDateinput = document.getElementById('booking_start_date');
//    const endDateinput = document.getElementById('booking_end_date');

//     if (startDateinput && endDateinput) {
//      flatpickr(startDateinput, {
//      minDate: 'today',
//      dateFormat: 'd-m-Y',
//      onChange: function(_, selectedDate) {
//        if (selectedDate === '') {
//          return endDateinput.disabled = true;
//        }
//        endDateCalendar.set('minDate', selectedDate);
//        endDateinput.disabled = false;
//      }
//    });
//      const endDateCalendar =
//        flatpickr(endDateinput, {
//          dateFormat: 'd-m-Y',
//        });
//    }
//  };



// from params -> rails
// >>  @booking
// => #<Booking id: 11, start_date: "2019-03-29", end_date: "2019-03-30", user_id: 1, developer_id: 10, created_at: "2019-03-26 21:23:12", updated_at: "2019-03-26 21:23:12">
// >>  @developer.unavailable_dates
// => [{:from=>Wed, 27 Mar 2019, :to=>Thu, 28 Mar 2019}, {:from=>Mon, 01 Apr 2019, :to=>Wed, 03 Apr 2019}, {:from=>Fri, 29 Mar 2019, :to=>Sat, 30 Mar 2019}]

// We have two date inputs, so we need to generate two instances of flatpickr and we will disable the end_date input until we have a selected start_date.

// We have two date inputs, so we need to generate two instances of flatpickr and we will disable the end_date input until we have a selected start_date. We will do this via flatpickr’s onChange event. Here, we will also implement the validation that the end_date needs to come after the start_date by specifying the minDate is the same as the selected start_date plus one.

// We stringify the unavailable dates and add them to the dataset of an HTML element as data-unavailable="<%= @developer.unavailable_dates.to_json %>. We then parse it in our JavaScript component and pass it into both flatpickr instances as the value for the option disable.
