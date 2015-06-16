$ !->
  # 激活bootstrap的tab组件
  $ '#myTab a' .click (e)!->
    e.preventDefault!
    $ @ .tab 'show'

  # 激活bootstrap的轮播（slider）组件
  $ '.carousel' .carousel!

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

  # 隐藏超出5个之外的“我订阅的标签”标签
  my-tag-num = $ '.active .my_tag .tag' .length
  if my-tag-num <= 5    # 若不足五个，隐藏“展开”按钮
    $ '.my_tag .slide_toggle' .hide!
  else
    for i from 5 to my-tag-num - 1
      $ ($ '#future .my_tag .tag')[i] .add-class 'slide_tag'
    for i from 5 to my-tag-num - 1
      $ ($ '#past .my_tag .tag')[i] .add-class 'slide_tag'
    for i from 5 to my-tag-num - 1
      $ ($ '#all .my_tag .tag')[i] .add-class 'slide_tag'

  # 同上，隐藏超出5个之外的“热门标签”标签    
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

  # 点击“展开”时，呈现剩余标签，同时切换成“收起”
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

  # 点击排序按钮后，激活状态切换
  $ '.sort_area .sort' .click !->
    $ '.sort_area .sort' .removeClass 'active'
    $ @ .addClass 'active'
    get-acts! # 向后台获取活动

  # 点击标签
  $ '.tag_item' .click (e)!->
    target = $ e.target
    # 如果已经被选，则取消被选，同时在上方“已选标签”中去除
    if $ @ .has-class 'chosen'
      $ @ .remove-class 'chosen'
      for x in $ '.tag_selected'
        if ($ x .data 'id') is (target.data 'id')
          $ x .remove!
    else # 如果未被选，则选中，同时在上方“已选标签”中插入元素
      $ @ .add-class 'chosen'
      tag-name = $ '<span class="name"></span>' .text ($ @ .text!)
      tag-selected = $ '<div class="tag_selected" data-id="' + (target.data 'id') + '"></div>'
      tag-selected .append tag-name
      tag-selected .append "<img class='tag_close' src='images/close.png'>"
      $ '.tag_chosen' .append tag-selected
    get-acts!

  # 点击“已选标签”的关闭按钮
  $ ".tag_chosen" .on 'click','.tag_close',!->
    target = $ @.parentNode
    for x in $ '.tag_item'   # 找到下方相应的复选框，取消选中
      if ($ x .data 'id') is (target.data 'id')
        $ x .remove-class 'chosen'
    @.parentNode .remove!
    get-acts!

  # 点击活动时段
  $ '.timing' .click !->
    # 还原tab中的所有内容，包括清除所有标签，回到默认的按时间排序
    $ '.tag_item' .remove-class 'chosen'
    $ '.tag_selected' .remove!
    $ '.sort_area .sort' .removeClass 'active'
    $ '.time' .addClass 'active'
    get-acts!

  # 处理下一页、上一页按钮的激活和灭活
  paging-handler = !->
    for x in $ '.timing'
      if $ x .has-class 'active'
        time-bucket = $ x .data 'id'
        break
    time-id = '#' + time-bucket   # 限定在当前时段的tab中
    $ '.previous,.next' .remove-class 'disabled'
    for x in $ time-id+' .paging'
      if $ x .parent! .has-class 'active'
        current-page = $ x .data 'id'
    if current-page is 1   # 通过当前页码来判断是否需要灭活下一页、上一页按钮
      $ time-id+' .pagination .previous' .add-class 'disabled'
    if current-page is $ time-id+' .paging' .length
      $ time-id+' .pagination .next' .add-class 'disabled'
  paging-handler!

  # 点击页码
  $ ".pagination" .on 'click','.paging',(e)!->
    for x in $ '.timing'
      if $ x .has-class 'active'
        time-bucket = $ x .data 'id'
        break
    time-id = '#' + time-bucket
    e.preventDefault!
    target = $ e.target.parentNode
    if target .has-class 'active'
      return
    $ time-id+' .pagination li' .remove-class 'active'
    target .add-class 'active'
    paging-handler!
    get-acts true
  # 点击上一页、下一页
  $ ".pagination" .on 'click','.previous,.next',(e)!->
    for x in $ '.timing'
      if $ x .has-class 'active'
        time-bucket = $ x .data 'id'
        break
    time-id = '#' + time-bucket
    e.preventDefault!
    target = $ e.target
    if target .parent! .has-class 'disabled'
      return  # 如果按钮灭活了，不处理
    for x in $ time-id+' .paging'
      if $ x .parent! .has-class 'active'
        if (target .data 'id') is 0
          $ x .parent! .prev! .add-class 'active'
          $ x .parent! .remove-class 'active'
          break
        else if (target .data 'id') is -1
          $ x .parent! .next! .add-class 'active'
          $ x .parent! .remove-class 'active'
          break
    paging-handler!
    get-acts true

  # 向后台获取活动的函数
  get-acts = (page-is-changed)!->
    # 获取选择的时段
    for x in $ '.timing'
      if $ x .has-class 'active'
        time-bucket = $ x .data 'id'
        break
    time-id = '#' + time-bucket
    # 如果改变的不是页码，自动将页码设为1
    if page-is-changed isnt true
      page-num = 1
    else
      # 如果改变的是页码，获取页码
      for x in $ time-id+' .paging'
        if $ x .parent! .has-class 'active'
          page-num = $ x .data 'id'
    
    # 获取选择的tag
    tags = []
    for x in $ time-id+' .tag_selected'
      tags.push ($ x .data 'id')
    # 获取排序依据
    for x in $ time-id+' .sort'
      if $ x .has-class 'active'
        order-by = $ x .data 'id'
        break
    $ '.activities-template' .stop!  # 阻止未完成的动画，防止作死的用户频繁点击，造成页面闪烁
    s-homepage-update time-bucket, tags, order-by, page-num

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

    # 处理页码
    time-id = '#' + time-bucket # 限定在当前的时段tab中
    # page-previous = $ time-id+' .previous'
    # page-next = $ time-id+' .next'
    $ time-id+' .pagination li' .remove!
    if data.num-of-pages isnt 0
      page-previous = $ '<li class="previous">'
      page-previous-a = $ '<a href="#" data-id="0">&laquo;</a>'
      page-previous .append page-previous-a
      $ time-id+' .pagination' .append page-previous
      for i from 1 to data.num-of-pages
        if i is page-num
          page-li = $ '<li class="active">'
        else
          page-li = $ '<li>'
        page-a = $ '<a class="paging" href="#" data-id="' + i + '">' + i + '</a>'
        page-li .append page-a
        $ time-id+' .pagination' .append page-li
      page-next = $ '<li class="next">'
      page-next-a = $ '<a href="#" data-id="-1">&raquo;</a>'
      page-next .append page-next-a
      $ time-id+' .pagination' .append page-next
      paging-handler!

