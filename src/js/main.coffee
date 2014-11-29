console.log "Hi Folks!"

$(".dropdown").click ->
  $(this).toggleClass "open"
  return