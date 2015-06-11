$ !->
  $ '.post_comment' .submit (e) !->
    data = $ '.post_comment' .serialize()
    $.post '/s-comment-save?type=new', data, (results)!->
      new_data = $ results .hide()
      $ '.act_comments_main' .append new_data
      $ '#comment_content' .val ''

      comment_number = parseInt($ '#max_comments' .text())
      comment_number++
      $ 'max_comments' .text comment_number

      if comment_number/5 != parseInt($ '#max_comment_page' .text())
        alert "queye"
      new_data .slideDown()
    return false