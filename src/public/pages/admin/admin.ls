$ !->
  # 点击审核通过
  $ '.accept_button' .click (e)!->
    target = $ e.target
    id = target.data 'id'
    tr = $ '.item-id-' + id
    $.get '/s-activity-admin-update?id='+id, (results)!->
      if results.success is 1
        if tr.length > 0
          tr.remove!
  # 窗口向下滚动时，出现回到顶部按钮
  $ window .scroll !->
    scrollt = document.document-element.scroll-top + document.body.scroll-top
    if scrollt > 200
      $ '.back_to_top' .fade-in!
    else
      $ '.back_to_top' .stop! .fade-out!

  # 点击回到顶部
  $ '.back_to_top' .click !->
    $ 'html,body' .animate {scroll-top: '0px'}, 200