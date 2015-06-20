$ !->
  $ '.del' .click (e)!->
    target = $ e.target
    id = target.data 'id'
    tr = $ '.item-id-' + id
    $.get '/s-activity-delete?id='+id, (results)!->
      if results.success is 1
        if tr.length > 0
          tr.remove!