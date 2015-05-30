require! {'../../Passport/Passport'}
require! {'../../models/User'}

module.exports = (req, res)!->
  # x inputs from body
  username = req.body.username
  password = req.body.password
  email = req.body.email
  tags = req.body.tags
  # signup
  # check if username exists
  User.find username: username, (err, docs)!->
    if err
      'handler error'
    else
      # username exists
      if docs.length > 0
        res.end 'username exists'
      # ok
      else
        User.create {
          username: username
          password: password
          email: email
          tags: tags
          role: 0
        }, (err)!->
          if err
            'handle error'
          else
            res.end 'ok'
