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
  $ '.post_comment' .submit (e) !->
    data = $ '.post_comment' .serialize()
    comment_number = parseInt($ '#max_comments' .text())
    comment_number++
    page_number = parseInt($ '#max_comment_page' .text())
    flag = false
    if Math.ceil(comment_number/5) != parseInt($ '#max_comment_page' .text())
      flag = true
      $ '#max_comment_page' .text page_number+1
      page_number++
      new_li = '<li><a id="comment_page_nav'+page_number+'" page="'+page_number+'" href="javascript:void(0)" class="comment_page_nav">'+page_number+'</a></li>'
    alert data    
    $.post '/s-comment-save?type=new&page='+page_number, data, (results)!->
      new_data = $ results .hide()
      $ '.act_comments_main' .append new_data
      $ '#comment_content' .val ''
      if flag
        $ '#Next_comment_page' .before new_li
      $ '#max_comments' .text comment_number
      paging_update page_number
      if page_number == 1
        $ '.pagination' .show 500
      new_data .slideDown()
    return false