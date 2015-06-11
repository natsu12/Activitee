$ !->
  $ '.comment_page_nav' .click (e)!->
    target = $ e.target
    page_number = parseInt($ target .attr 'page')
    isActive = target .parent() .attr 'class'
    if isActive == 'active'
      return false
    comments = $ '.comment_area'
    for  comment in comments
      if (parseInt($ comment .attr 'page') == page_number)
        $ comment .show 500
      else
         $ comment .hide 500

    $ '.active' .attr 'class' ''
    $ ($ '#comment_page_nav'+page_number .parent()) .attr 'class' 'active'

    if page_number == 1
      $ '#Previous_comment_page' .attr 'class' 'disabled'
    else if page_number == parseInt($ '#max_comment_page' .text())
      $ '#Next_comment_page' .attr 'class' 'disabled'
    else
      $ '#Previous_comment_page' .attr 'class' ''
      $ '#Next_comment_page' .attr 'class' ''

    $ '#Previous_comment_page' .attr 'current' page_number
    $ '#Next_comment_page' .attr 'current' page_number
    return false

  $ '#Previous_comment_page' .click (e) !->
    page_number = parseInt($ '#Previous_comment_page' .attr 'current')

    if page_number == 1
      return false
    page_number -= 1
    comments = $ '.comment_area'

    for  comment in comments
      if (parseInt($ comment .attr 'page') == page_number)
        $ comment .show 500
      else
         $ comment .hide 500

    $ '.active' .attr 'class' ''
    $ ($ '#comment_page_nav'+page_number .parent()) .attr 'class' 'active'

    if page_number == 1
      $ '#Previous_comment_page' .attr 'class' 'disabled'
    else if page_number == parseInt($ '#max_comment_page' .text())
      $ '#Next_comment_page' .attr 'class' 'disabled'
    else
      $ '#Previous_comment_page' .attr 'class' ''
      $ '#Next_comment_page' .attr 'class' ''

    $ '#Previous_comment_page' .attr 'current' page_number
    $ '#Next_comment_page' .attr 'current' page_number
    return false

  $ '#Next_comment_page' .click (e) !->
    page_number = parseInt($ '#Next_comment_page' .attr 'current')

    if page_number >= parseInt($ '#max_comment_page' .text())
      return false
    page_number += 1
    comments = $ '.comment_area'

    for  comment in comments
      if (parseInt($ comment .attr 'page') == page_number)
        $ comment .show 500
      else
         $ comment .hide 500

    $ '.active' .attr 'class' ''
    $ ($ '#comment_page_nav'+page_number .parent()) .attr 'class' 'active'

    if page_number == 1
      $ '#Previous_comment_page' .attr 'class' 'disabled'
    else if page_number == parseInt($ '#max_comment_page' .text())
      $ '#Next_comment_page' .attr 'class' 'disabled'
    else
      $ '#Previous_comment_page' .attr 'class' ''
      $ '#Next_comment_page' .attr 'class' ''

    $ '#Previous_comment_page' .attr 'current' page_number
    $ '#Next_comment_page' .attr 'current' page_number
    return false