# $ '#signup-form' .submit (evt)!->
  # evt.preventDefault!
  # $.ajax do
    # type: 'POST'
    # url: '/s-signup'
    # processData: false
    # contentType: false
    # data: new FormData(@)
    # success: (msg)!->
      # if msg == 'ok'
        # location.href = '/home'
      # else
        # alert msg

$ !->
  stepWidth = $('#signup-step-1-container').width! + 1
  
  $('#signup-step-1-next').click !->
    $('#signup-slider-content').css 'left', "#{-stepWidth}px"
    $('#signup-step-2').addClass 'signup-step-activated'
  
  $('#signup-form').submit (e)!->
    e.preventDefault!
    data = new FormData(@)
    $.ajax do
      type: 'POST'
      url: '/s-signup'
      processData: false
      contentType: false
      data: data
      success: (msg)!->
        if msg == 'ok'
          $('#signup-slider-content').css 'left', "#{-2 * stepWidth}px"
          $('#signup-step-3').addClass 'signup-step-activated'
        else
          alert msg
  
  $('#signup-step-2-prev').click !->
    $('#signup-slider-content').css 'left', '0'
    $('#signup-step-2').removeClass 'signup-step-activated'

  $('#signup-tags').tagsinput {
    tagClass: 'signup-tag-checked'
    itemValue: 'value'
    itemText: 'text'
  }
  
  $('.signup-tag').click !->
    _id = $(@).attr '_id'
    name = $(@).text!
    $('#signup-tags').tagsinput 'add', {
      value: _id
      text: name
    }
