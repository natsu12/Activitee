$ !->
  $ '#cover-input' .mouseenter !->
    $ '#cover-form .button' .add-class 'hover'
  $ '#cover-input' .mouseleave !->
    $ '#cover-form .button' .remove-class 'hover'
  $ '#cover-input' .change !->
    $ '#cover-form .text' .hide!
    $ '#cover-preview' .show!
  $ '#upload_wrap .next' .click (evt)!->
    evt.preventDefault!
    $.ajax do
      type: 'POST'
      url: '/s-upload-img/'+$ '.id' .val!
      processData: false
      contentType: false
      data: new FormData ($ '#cover-form')[0]
      success: (msg)!->
        if msg == 'ok'
          location.href = '/home'
        else
          alert msg
