$ !->
  $ '.reply' .click (e)!->
    target = $ e.target
    id = target.data 'to'
    username = target.data 'user'
    comment = target.data 'comment'
    $ '#reply_to'+comment .attr 'value' id
    $ '#reply_content'+comment .attr 'placeholder' '回复'+username
    $ '#reply_to'+comment .focus
    return false