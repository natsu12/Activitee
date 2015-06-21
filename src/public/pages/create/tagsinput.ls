$ !->
  $ '#inputTime' .datetimepicker!
  input = $ '.bootstrap-tagsinput > input'
  input .attr "readonly", "readonly"
  $ '.btn-addTag' .each !->
    ($ @).click !->
      /* will be wrong if there are more than one input */
      input.val input.val! + ($ @).text!
      press = jQuery.Event("keypress");
      press.ctrlKey = false;
      press.which = 13;
      input.trigger press

  
