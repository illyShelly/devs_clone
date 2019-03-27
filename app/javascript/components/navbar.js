function initUpdateNavbarOnScroll() {
   const navbar = document.querySelector('.navbar-wagon');
   if (navbar) {
     document.addEventListener('scroll', () => {
       if (document.scrollY >= window.innerHeight) {
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
