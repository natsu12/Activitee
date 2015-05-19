$ !->
  $ '.del' .click (e)!->
    target = $ e.target
    id = target.data 'id'
    tr = $ '.item-id-' + id
    $.ajax {
      type: 'DELETE'
      url: '/host?id=' + id
    }
    .done (results)!->
      if results.success is 1
        if tr.length > 0
          tr.remove!