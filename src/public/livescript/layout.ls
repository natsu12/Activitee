$ !->
  $ '.profile' .click !->
    if $ '.profile-menu' .hasClass 'hide'
      $ '.profile-menu' .removeClass 'hide'
    else
      $ '.profile-menu' .addClass 'hide'
