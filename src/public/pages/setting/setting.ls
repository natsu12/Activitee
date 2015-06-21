$ '#avatar-form' .submit (evt)!->
  evt.preventDefault!
  $.ajax do
    type: 'POST'
    url: '/s-user-save'
    processData: false
    contentType: false
    data: new FormData(@)
    success: (msg)!->
      if msg == 'ok'
        location.href = '/setting'
      else
        alert msg

$ !->
  $ '#inputTime' .datetimepicker!
  $ '.btn-addTag' .each !->
    ($ @).click !->
      /* will be wrong if there are more than one input */
      input = $ '.bootstrap-tagsinput > input'
      input.val input.val! + ($ @).text!
      press = jQuery.Event("keypress");
      press.ctrlKey = false;
      press.which = 13;
      input.trigger press

  $ '.auth' .click (e)!->
    e.preventDefault!
    $.get '/s-send-email' (msg)!->
      if msg == 'ok'
        $ '.auth' .text '邮件已发送，请登陆邮箱完成验证'
