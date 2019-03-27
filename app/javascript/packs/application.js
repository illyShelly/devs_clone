import "bootstrap";
import './application.css';
// import { toggleIcons } from '../components/bookmarking';
import { toggleDateInputs } from '../components/booking';
import { initUpdateNavbarOnScroll } from '../components/navbar';

const homePage = document.querySelector('.pages.home');
if (homePage) {
  initUpdateNavbarOnScroll();
  toggleIcons();
}

// const homePage = document.querySelector('.pages.home');
// if (homePage) {
//   loadDynamicBannerText();
//   initUpdateNavbarOnScroll();
//   toggleIcons();
//   autocompleteSearch();
// }
// const devIndexPage = document.querySelector('.developers.index');
// if (devIndexPage) {
//   toggleIcons();
// }

// flatpickr
toggleDateInputs();
// navbar scroll effect
initUpdateNavbarOnScroll();

