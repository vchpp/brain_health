
// ...
//= require activestorage
//= require trix/dist/trix
//= require jquery
//= require jquery_ujs
//= require popper
//= require jquery.easing.1.3
//= require bootstrap
//= require owl.carousel.min
//= require jquery.magnific-popup.min
//= require hoverIntent
//= require supersubs
//= require respond.min
//= require modernizr-2.6.2.min
//= require jquery.parallax-scroll.min
//= require superfish
//= require easyResponsiveTabs
//= require fastclick
//= require custom
//= require main
window.addEventListener("load", () => {
  eventListeners();
});

function eventListeners(){
  // upLike();
  // downLike();
  submit_categories();
  getCookie('tid');
  selectActiveFilter();
  toggleCommentForm();
}

function getCookie(name) {
  match = document.cookie.match(new RegExp(name + '=([^;]+)'));
  if (match) return match[1];
}

function toggleCommentForm() {
  $('.reply').on('click', function(e){
    let container = this.closest(".fh5co-feature-blurb"); // Find the closest parent container
    let form = container.querySelector("div");

    if (form) {
      form.classList.toggle("hidden"); // Toggle the 'hidden' class
    }
    // let field = this.closest(".comment-field");
    // console.log("comment-field")
    // field.focus();
  })
};

function toggleComment() {
  $('.ti-comment-alt').on('click', function(e){
    console.log("click");
    // let container = this.closest(".fh5co-feature-blurb")
    // let body = container.classList("comment-body")
    // if (body) {
    //   body.classList.toggle("comment-body"); // Toggle the 'comment-body' class
    // }
  })
}



// upLike a message
function upLike(){
 $('#uplike').on('click', function(e){
   e.preventDefault();
   var tid = getCookie('tid');
   var value, postUrl, data;
   value = 1;
   postUrl = $(this).parent().parent().attr('action');
   data = $(this).parent().serialize();
   console.log(data);
   $.ajax({
     url: postUrl,
     method: 'POST',
     headers: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content'), // Optional
      'Content-Type': 'application/json'
      },
     data: JSON.stringify({ "up": value }),
   }).done(function(data) {
     $('.uplike').empty();
     $('.uplike').prepend(data);
   });
 })
};

// downLike a message
function downLike(){
 $('#downlike').on('submit', function(e){
   console.log("prevented downlike")
   e.preventDefault();
   $(this).siblings('.del').toggle();
   var tags, postUrl, data;
   tags = $(this);
   postUrl = $(this).attr('action');
   data = $(this).children(':first').serialize();
   $.ajax({
     url: postUrl,
     method: 'PUT',
     data: data
   }).done(function(data) {
     tags.toggle();
     $('.tag-value').empty();
     $('.tag-value').prepend(data);
   });
 })
};

function submit_categories(){
  $('select').change(function(){
    $('#category').submit();
  });
}

function selectActiveFilter(){
  var queryString = window.location.href.slice(window.location.href.indexOf('='));
  queryParam = queryString.replace(/=/g, '');
  queryParam = queryParam.replace(/\+/g, ' ');
  $("#category-form > option[value='" + queryParam + "']").prop('selected', true)
};
