(function() {
  console.log("Hi Folks!");

  $(".dropdown").click(function() {
    $(this).toggleClass("open");
  });

}).call(this);
