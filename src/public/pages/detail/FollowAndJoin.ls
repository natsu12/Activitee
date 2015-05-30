$ !->
  $ '#follow' .click !->
    id = $ '#follow' .attr 'data-id'
    $.get '/s-activity-follow?id=' + id, (results) !->
      if results.success is 1
        $ '#follow' .attr 'disabled' 'disabled'
        $ '#follow' .text '已关注'
        $ '#follow' .attr 'id' ''
        $ '#follows' .text results.follows

  $ '#join' .click !->
    id = $ '#join' .attr 'data-id'
    $.get '/s-activity-join?id=' + id, (results) !->
      if results.success is 1
        $ '#join' .attr 'disabled' 'disabled'
        $ '#join' .text '已参加'
        $ '#join' .attr 'id' ''
        $ '#joins' .text results.joins
