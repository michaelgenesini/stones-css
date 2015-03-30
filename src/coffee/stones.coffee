console.log "Hi Folks!"

$(".dropdown").click ->
  $(this).find("ul").toggleClass "open"
  return