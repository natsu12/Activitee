$ '#signup-form' .submit (evt)!->
  evt.preventDefault!
  $.post '/s-signup', $(@).serialize!, (msg)!->
    if msg == 'ok'
      location.href = '/home'
    else
      alert msg
