paging_update = (page_number)!->
  comments = $ '.comment_area'

  for  comment in comments
    if (parseInt($ comment .attr 'page') == page_number)
      $ comment .show 400
    else
       $ comment .hide 400

  $ '.active' .attr 'class' ''
  $ ($ '#comment_page_nav'+page_number .parent()) .attr 'class' 'active'
  $ '#Previous_comment_page' .attr 'current' page_number
  $ '#Next_comment_page' .attr 'current' page_number

  if page_number == 1
    $ '#Previous_comment_page' .attr 'class' 'disabled'
    $ '#Next_comment_page' .attr 'class' ''
    return
  if page_number == parseInt($ '#max_comment_page' .text())
    $ '#Next_comment_page' .attr 'class' 'disabled'
    $ '#Previous_comment_page' .attr 'class' ''
    return
  if page_number == 1 && page_number == parseInt($ '#max_comment_page' .text())
    $ '#Previous_comment_page' .attr 'class' 'disabled'
    $ '#Next_comment_page' .attr 'class' 'disabled'

  $ '#Previous_comment_page' .attr 'class' ''
  $ '#Next_comment_page' .attr 'class' ''

$ !->
  $ "body" .on "click", '.comment_page_nav' (e)!->
    target = $ e.target
    page_number = parseInt($ target .attr 'page')
    isActive = target .parent() .attr 'class'
    if isActive == 'active'
      return false
    paging_update page_number
    return false

  $ "body" .on "click", '#Previous_comment_page' (e) !->
    page_number = parseInt($ '#Previous_comment_page' .attr 'current')

    if page_number == 1
      return false
    page_number -= 1
    paging_update page_number
    return false

  $ "body" .on "click", '#Next_comment_page' (e) !->
    page_number = parseInt($ '#Next_comment_page' .attr 'current')

    if page_number >= parseInt($ '#max_comment_page' .text())
      return false
    page_number += 1
    paging_update page_number
    return false

