$ !->
  $ '.profile' .click !->
    if $ '.profile-menu' .hasClass 'hide'
      $ '.profile-menu' .removeClass 'hide'
    else
      $ '.profile-menu' .addClass 'hide'

  $ document .click (e)!->
    target = e.srcElement || e.target
    profile = ($ '.profile')[0]

    while target and target isnt document and target isnt profile
      target = target.parentNode
    if target is document
      $ '.profile-menu' .addClass 'hide'

  if $ '#home_wrap' .length isnt 0
    $ '#header .nav a' .removeClass 'active'
    $ '#header .home' .addClass 'active'
  else if $ '#host_wrap' .length isnt 0
    $ '#header .nav a' .removeClass 'active'
    $ '#header .host' .addClass 'active'
  else
    $ '#header .nav a' .removeClass 'active'