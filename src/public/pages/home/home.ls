$ !->
  $ '#myTab a' .click (e)!->
    e.preventDefault!
    $ this .tab 'show'

  $ '.carousel' .carousel!

  $ '.sort_area .sort' .click (e)!->
    e.preventDefault!
    $ '.sort_area .sort' .removeClass 'active'
    $ this .addClass 'active'

  $ '.tag' .click (e)!->
    e.preventDefault!
    target = $ e.target
    for tag in $ '.tag'
      # console.log '========'
      # console.log tag
      # console.log '========'
      # if ($ tag .attr('aria-pressed'))
      if ($ tag .hasClass 'active')
        console.log tag
    id = target.data 'id'
    console.log id
    # 刷新
    s-homepage-update "future",[],"attention",1

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
    $ '#activities-template' .html(data.activities-template)
    # console.log data


