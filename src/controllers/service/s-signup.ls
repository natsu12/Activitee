require! {
  '../../passport/passport'
  User: '../../models/user'
  '../../mail/mail'
}

host = 'http://localhost'

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
        authCode = Math.random!toString!
        User.create {
          username: username
          password: passport.hash password
          email: email
          tags: tags
          role: 0
          authenticated: 0
          authCode: authCode
        }, (err)!->
          if err
            'handle error'
          else
            # send auth mail
            mail.send email, 'auth mail', "<a href='#{host}/s-auth/#{authCode}'>#{authCode}</a>"
            res.end 'ok'
