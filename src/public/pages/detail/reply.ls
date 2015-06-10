$ !->
  $ "body" .on "click"," .reply_master" (e)!->
    target = $ e.target
    comment = target.data 'comment'
    $ '#reply_form'+comment .show 250
    $ '#reply_to'+comment
    $ '#reply_content'+comment .attr 'placeholder' '回复楼主'
    $ .scrollTo('#reply_content'+comment, 1000)
    $ '#reply_content'+comment .focus()
    return false

  $ "body" .on "click"," .reply" (e)!->
    target = $ e.target
    id = target.data 'to'
    username = target.data 'user'
    comment = target.data 'comment'
    $ '#reply_form'+comment .show 500
    $ '#reply_to'+comment .attr 'value' id
    $ '#reply_content'+comment .attr 'placeholder' '回复'+username
    $ '#reply_to'+comment
    $ .scrollTo('#reply_content'+comment, 1000)
    $ '#reply_content'+comment .focus()
    return false
  
  $ '.fold_comment' .click (e)!->
    target = $ e.target
    comment = target.data 'comment'
    $ '#replies'+comment .toggle 500
    $ '#reply_form'+comment .hide 250
    return false

  $ '.post_reply' .submit (e) !->
    target = $ e.target
    comment = target.data 'comment'
    data = $ '#post_reply'+comment .serialize()
    $.post '/s-comment-save?type=reply', data, (results)!->
      $ '#replies'+comment .show()
      new_data = $ results .hide()
      reply_number = parseInt($ '#reply_number'+comment .text()) + 1
      $ '#reply_number'+comment .text reply_number
      $ '#replies'+comment .append new_data
      $ '#reply_content'+comment .val ''
      $.scrollTo('#reply_form'+comment, 500); 
      new_data .slideDown()
    return false
