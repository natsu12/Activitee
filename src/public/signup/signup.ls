$ '#signup-form' .submit (evt)!->
  evt.preventDefault!
  $.ajax do
    type: 'POST'
    url: '/s-signup'
    processData: false
    contentType: false
    data: new FormData(@)
    success: (msg)!->
      if msg == 'ok'
        location.href = '/home'
      else
        alert msg
