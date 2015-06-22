join_click = 0
follow_click = 0

$ !->
  $ '#follow' .click !->
    if follow_click >= 10
      alert '戳我戳太多了，表酱紫，我疼~~~~(>_<)~~~~ '
    id = $ '#follow' .attr 'data-id'
    if $ '#follow' .text() == '关注'
      $.get '/s-activity-follow?id=' + id, (results) !->
        if results.success is 1
          $ '#follow' .text '已关注'
          $ '#follows' .text results.follows + '人关注'
    else
      $.get '/s-activity-cancle-follow?id=' + id, (results) !->
        if results.success is 1
          follow_click++
          $ '#follow' .text '关注'
          $ '#follows' .text results.follows + '人关注' 

  $ '#follow' .hover !->
    if $ '#follow' .text() == '已关注'
      $ '#follow' .html '取消关注'
  ,!->
    if $ '#follow' .text() == '取消关注'
      $ '#follow' .html '已关注'

  $ '#join' .click !->
    if join_click >= 10
      alert '戳我戳太多了，表酱紫，我疼~~~~(>_<)~~~~ '
    id = $ '#join' .attr 'data-id'
    if $ '#join' .text() == '参加'
      $.get '/s-activity-join?id=' + id, (results) !->
        console.log results
        if results.success is 1
          $ '#join' .text '已参加'
          $ '#joins' .text results.joins + '人参加'
        else
          alert "本活动需要参加者的具体个人信息，请完善真实姓名和联系方式后再参加!(⊙_⊙)"
    else
      $.get '/s-activity-cancle-join?id=' + id, (results) !->
        if results.success is 1
          join_click++
          $ '#join' .text '参加'
          $ '#joins' .text results.joins + '人参加' 

  $ '#join' .hover !->
    if $ '#join' .text() == '已参加'
      $ '#join' .html '取消参加'
  ,!->
    if $ '#join' .text() == '取消参加'
      $ '#join' .html '已参加'

  $ '.not_login_button' .click !->
    alert '亲！没登录哦！╮(╯▽╰)╭'
