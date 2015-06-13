$ !->
  $ '#myTab a' .click (e)!->
    e.preventDefault!
    $ @ .tab 'show'

  $ '.carousel' .carousel!

  my-tag-num = $ '.active .my_tag .tag' .length
  if my-tag-num <= 5
    $ '.my_tag .slide_toggle' .hide!
  else
    for i from 5 to my-tag-num - 1
      $ ($ '#future .my_tag .tag')[i] .add-class 'slide_tag'
    for i from 5 to my-tag-num - 1
      $ ($ '#past .my_tag .tag')[i] .add-class 'slide_tag'
    for i from 5 to my-tag-num - 1
      $ ($ '#all .my_tag .tag')[i] .add-class 'slide_tag'

  hot-tag-num = $ '.active .hot_tag .tag' .length
  if hot-tag-num <= 5
    $ '.hot_tag .slide_toggle' .hide!
  else
    for i from 5 to hot-tag-num - 1
      $ ($ '#future .hot_tag .tag')[i] .add-class 'slide_tag'
    for i from 5 to hot-tag-num - 1
      $ ($ '#past .hot_tag .tag')[i] .add-class 'slide_tag'
    for i from 5 to hot-tag-num - 1
      $ ($ '#all .hot_tag .tag')[i] .add-class 'slide_tag'

  $ '.my_tag .slide_toggle' .click !->
    $ '.active .my_tag .slide_tag' .slide-toggle 'fast'
    if $ @ .text! is '展开'
      $ @ .text '收起'
    else
      $ @ .text '展开'

  $ '.hot_tag .slide_toggle' .click !->
    $ '.active .hot_tag .slide_tag' .slide-toggle 'fast'
    if $ @ .text! is '展开'
      $ @ .text '收起'
    else
      $ @ .text '展开'




  $ '.sort_area .sort' .click !->
    $ '.sort_area .sort' .removeClass 'active'
    $ @ .addClass 'active'

  $ '.tag_item' .click (e)!->
    target = $ e.target
    if $ @ .has-class 'chosen'
      $ @ .remove-class 'chosen'
      for x in $ '.tag_selected'
        if ($ x .data 'id') is (target.data 'id')
          $ x .remove!
    else
      $ @ .add-class 'chosen'
      tag-name = $ '<span class="name"></span>' .text ($ @ .text!)
      tag-selected = $ '<div class="tag_selected" data-id="' + (target.data 'id') + '"></div>'
      tag-selected .append tag-name
      tag-selected .append "<img class='tag_close' src='images/close.png'>"
      $ '.tag_chosen' .append tag-selected
    get-acts!

  $ ".tag_chosen" .on 'click','.tag_close',!->
    target = $ @.parentNode
    for x in $ '.tag_item'
      if ($ x .data 'id') is (target.data 'id')
        $ x .remove-class 'chosen'
    @.parentNode .remove!
    get-acts!

  $ '.sort' .click !->
    get-acts!

  $ '.timing' .click !->
    $ '.tag_item' .remove-class 'chosen'
    $ '.tag_selected' .remove!
    $ '.sort_area .sort' .removeClass 'active'
    $ '.time' .addClass 'active'
    get-acts!

  $ '.paging' .click (e)!->
    e.preventDefault!
    $ '.pagination li' .remove-class 'active'
    target = $ e.target.parentNode
    target .add-class 'active'

  get-acts = !->
    tags = []
    for x in $ '.timing'
      if $ x .has-class 'active'
        time-bucket = $ x .data 'id'
    for x in $ ('#' + time-bucket + ' .tag_selected')
      tags.push ($ x .data 'id')
    for x in $ '.sort'
      if $ x .has-class 'active'
        order-by = $ x .data 'id'
        break
    
    s-homepage-update time-bucket, tags, order-by, 1

  # @time-bucket type:String 表示即将进行的(future)、已过期的(past)或者是所有的(all)
  # @tags type:list 表示处于active状态的标签集合
  # @order-by type:String 表示排序的依据,包括 时间(time),关注度(attention),参与度(participation)
  # @page-num type:integer 表示返回的页码
  s-homepage-update = (time-bucket, tags, order-by, page-num)!->
    option = {
      time-bucket: time-bucket
      tags: tags
      order-by: order-by
      page-num: page-num
    }
    # console.log 'begin ajax'
    (data) <-! $.get '/s-homepage-update', option
    # 界面渲染
    # 渲染代码
    $ '.activities-template' .html(data.activities-template)
    $ '.activities-template' .hide!
    $ '.activities-template' .fade-in!


