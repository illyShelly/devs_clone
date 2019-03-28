import flatpickr from 'flatpickr';

const numberWithCommas = (number) => {
  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}
// to parse dates from the input fields
const parseDate = (string) => {
  // const pattern = /(\d{2})-(\d{2})-(\d{4})/;
  // return new Date(string.replace(pattern,'$3-$2-$1'));
  return new Date(string);
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
          }
          else {
            // console.log(startDateInput.value); // 2019-04-27
            console.log(unavailableDates); // ["2019-03-27", "2019-04-02",...

            // console.log(startDate); Sat Apr 27 2019 02:00:00 GMT+0200 (Central European Summer Time)
            let startDate = parseDate(startDateInput.value);
            let endDate = parseDate(endDateInput.value);

          // 1. create method to return every date between picked dates in the Form
              // Returns an array of dates between the two dates
            var getDates = function(startDate, endDate) {
                var dates = [],
                    currentDate = startDate,
                    addDays = function(days) {
                      var date = new Date(this.valueOf());
                      date.setDate(date.getDate() + days);
                      return date;
                    };
                while (currentDate <= endDate) {
                  dates.push(currentDate);
                  currentDate = addDays.call(currentDate, 1);
                }
                // console.log("return all picked dates: ${dates}")
                return dates;
              };
          // 2. get all dates from chosen dates in calender - not converted yet
            var pickedDates = getDates(startDate, endDate);
              // console.log(pickedDates);

          // 3. Method to convert this: Sat Apr 27 2019 02:00:00 GMT+0200 (Central European Summer Time) to yyyy/mm/dd
            function convert(str) {
              var date = new Date(str),
                  mnth = ("0" + (date.getMonth()+1)).slice(-2),
                  day  = ("0" + date.getDate()).slice(-2);
              return [ date.getFullYear(), mnth, day ].join("-");
            }

          // 4. check whether or not dates are between unavailable dates yyyy/mm/dd
            // empty array for converted picked dates

            var pickToConvert = function(pickDates) {
              var convertPickedArr = [];

              pickDates.forEach(function(longDate) {
              // iterate through start and end_date and call convert fce yyyy/mm/dd
                convertPickedArr.push(convert(longDate));
              });
              return convertPickedArr;
            };
            // call function and convert all dates between start_date and end_date -> array
            var datesConverted = pickToConvert(pickedDates);
              console.log('Picked dates -> converted:')
              console.log(datesConverted);


            var flickrCalender = document.querySelector('div.flatpickr-calender');
            var widgetDiv = document.querySelector('.widget-heading');

            // 5. check if chosen date match date from unavailableDates - new method in model
            // some method: https://stackoverflow.com/questions/37896484/multiple-conditions-for-javascript-includes-method
            var comparison = function(convertedDates) {
              var result = unavailableDates.some(bookedDate => convertedDates.includes(bookedDate));
              // console.log(result); true
              if (result === true) {
                console.log("Match - already booked!");
                // inform user appending paragraph to widget
                // alertDiv.insertAdjacentHTML('beforeend', '<div class="alert-days">Select at least 2 consecutive days!<div>');

                // Create a <div> node
                var node = document.createElement("div");
                // Create a text node - alert
                var textnode = document.createTextNode("Select at least 2 consecutive days!");
                // Append the text to <div>
                node.appendChild(textnode);
                // Append <div> to widget-heading
                var alertDiv = widgetDiv.appendChild(node);
                alertDiv.classList.add('alert-days');

                // clear input value of chosen dates
                startDateInput.value = '';
                endDateInput.value = '';
                // be sure costs -> are not visible
                costs.classList.remove('is-visible');
                // close window calender
                  if (flickrCalender != null) {
                    flickrCalender.close;
                  }
                // when click again on input start_date => alert disappear
                var fromDate = document.querySelector('.flatpickr-input');
                fromDate.addEventListener('click', function() {
                  var alertRemove = document.querySelector('.alert-days');
                  // console.log("disappear ....");
                  alertRemove.style.display = 'none';
                });
              }
              else {
                console.log("Dates not booked yet :)");
                // Count hours and display Total costs
                let hours = Math.round((endDate - startDate) / (1000 * 3600 * 24)  * 6);
                updateCosts(hours);
                costs.classList.add('is-visible');
              }
              return result;
            };
            // call above function -> using some method
            comparison(datesConverted);

            // // instead of else statement (running faster then code above) => callback fce
            // comparison(datesConverted, function() {
            //   console.log("Dates not booked yet :)");
            //   // Count hours and display Total costs
            //   let hours = Math.round((endDate - startDate) / (1000 * 3600 * 24)  * 6);
            //   updateCosts(hours);
            //   costs.classList.add('is-visible');
            // });
          }
        },


      });
  }
};

export { toggleDateInputs }

// * stackoverflow & github
// https://stackoverflow.com/questions/6291225/convert-date-from-thu-jun-09-2011-000000-gmt0530-india-standard-time-to
// https://gist.github.com/miguelmota/7905510

// Usage getDates method
// var dates = getDates(new Date(2013,10,22), new Date(2013,11,25));
// dates.forEach(function(date) {
//   console.log(date);
// });
// console.log(dates);

// Do not want to work with these format -> approach convert Picked Dates from form
// a. convert unavailable dates to date format (parseDate method)
// from "2019-03-27" to Sat Apr 27 2019 02:00:00 GMT+0200 (Central European Summer Time)

// var parse_unavailableDates = function(booked) {
//   var bookedArr = [];
//   booked.forEach(function(date) {
//     bookedArr.push(parseDate(date));
//   });
//   return bookedArr;
//   console.log(bookedArr);
// }
// var bookedDates = parse_unavailableDates(unavailableDates);
//   console.log("Booked dates");
//   console.log(bookedDates);


// now array of all dates
// ["2019-03-27", "2019-04-02", "2019-04-03", "2019-04-04", "2019-03-28", 2019-04-20", "2019-04-21", "2019-04-25"]

// changed by method in backend
// *
// 5) [{…}, {…}, {…}, {…}, {…}]0:
// {from: "2019-03-27", to: "2019-03-27"}
// 0:
// from: "2019-03-27"
// to: "2019-03-27"
// 1: {from: "2019-04-02", to: "2019-04-04"}
// 2: {from: "2019-03-28", to: "2019-03-29"}

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
