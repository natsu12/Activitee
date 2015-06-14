$ !->
  $ '#cover-input' .mouseenter !->
    $ '#cover-form .button' .add-class 'hover'
  $ '#cover-input' .mouseleave !->
    $ '#cover-form .button' .remove-class 'hover'

  $ '#cover-input' .change !->
    $ '#cover-form .text' .hide!
    $ '#cover-preview' .show!