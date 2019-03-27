function initUpdateNavbarOnScroll() {
   const navbar = document.querySelector('.navbar-wagon');
   if (navbar) {
     window.addEventListener('scroll', () => {
       if (window.scrollY >= window.innerHeight / 3) {
        // default is transparent -> in half of page -> filled class apply
         navbar.classList.remove('navbar-wagon-transparent');
         navbar.classList.add('navbar-wagon-filled');
       } else {
         navbar.classList.remove('navbar-wagon-filled');
         navbar.classList.add('navbar-wagon-transparent');
       }
     });
   }
 }

export { initUpdateNavbarOnScroll };
