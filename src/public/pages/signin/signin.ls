$ '#signin-form' .submit (evt)!->
  evt.preventDefault!
  $.post '/s-signin', $(@).serialize!, (msg)!->
    if msg == 'ok'
      location.href = '/home'
    else
      alert msg
