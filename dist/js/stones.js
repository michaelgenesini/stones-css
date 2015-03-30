(function() {
  console.log("Hi Folks!");

  $(".dropdown").click(function() {
    $(this).find("ul").toggleClass("open");
  });

}).call(this);
