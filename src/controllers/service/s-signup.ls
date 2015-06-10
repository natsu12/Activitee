require! {
  '../../passport'
  User: '../../models/user'
  '../../mail/mail'
  multer
  '../../imageCropper'
  path
}

host = 'http://localhost:5000'
avatarPath = path.join __dirname, '..', '..', '..', 'upload', 'avatars'

module.exports = (req, res)!->
  # x inputs from body
  username = req.body.username
  password = req.body.password
  email = req.body.email
  # tags = req.body.tags
  # signup
  # check if username exists
  User.find username: username, (err, docs)!->
    if err
      res.status 500 .end!
    else
      # username exists
      if docs.length > 0
        res.end 'username exists'
      # check if email exists
      User.find email: email, (err, docs)!->
        if err
          res.status 500 .end!
        else
          # email exists
          if docs.length > 0
            res.end 'email exists'
          # ok
          else
            imageCropper.save req, 'avatar', avatarPath, username, (path_)!->
              authCode = Math.random!toString!
              password := passport.hash password
              User.create {
                username: username
                password: password
                email: email
                # tags: tags
                role: 0
                authenticated: 0
                auth_code: authCode
                avatar: path_
              }, (err)!->
                if err
                  res.status 500 .end!
                else
                  # send auth mail
                  mail.send email, 'Activitee注册验证邮件', "请点击<a href='#{host}/s-auth/#{authCode}'>此链接</a>完成注册验证"
                  res.end 'ok'
