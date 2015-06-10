$ !->
  $ '#myTab a' .click (e)!->
    e.preventDefault!
    $ @ .tab 'show'

  $ '.carousel' .carousel!

  $ '.sort_area .sort' .click (e)!->
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


