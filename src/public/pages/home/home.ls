$ !->
  $ '#myTab a' .click (e)!->
    e.preventDefault!
    $ this .tab 'show'

  $ '.carousel' .carousel!

  $ '.sort_area .sort' .click (e)!->
    e.preventDefault!
    $ '.sort_area .sort' .removeClass 'active'
    $ this .addClass 'active'