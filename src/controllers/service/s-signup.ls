require! {
  '../../passport'
  User: '../../models/user'
  Tag: '../../models/tag'
  '../../authMail'
  multer
  '../../imageCropper'
  path
  async
  mongoose
}

DEFAULT_AVATAR = 'images/default_avatar.png'

usernameExists = (username, cb)!->
  User.find username: username, (err, docs)!->
    if err
      cb err
    else
      cb null, docs.length > 0

emailExists = (email, cb)!->
  User.find email: email, (err, docs)!->
    if err
      cb err
    else
      cb null, docs.length > 0

createUser = (data, cb)!->
  data.password = passport.hash data.password
  data.auth_code = Math.random!toString!
  data.authenticated = 0
  data.role = 0
  data.tags = data.tags.split(',')
  data.gender = parseInt(data.gender)
  data.avatar = DEFAULT_AVATAR
  User.create data, (err)!-> cb err, data.auth_code

module.exports = (req, res)!->
  # x inputs from body
  username = req.body.username
  password = req.body.password
  email = req.body.email
  gender = req.body.gender
  tags = req.body.tags
  # signup
  # check if username exists
  usernameExists username, (err, exists)!->
    if err
      console.log err
      res.status 500 .end!
    else if exists
      res.end 'username exists'
    else
      emailExists email, (err, exists)!->
        if err
          console.log err
          res.status 500 .end!
        else if exists
          res.end 'email exists'
        else
          createUser {
            username: username
            password: password
            email: email
            gender: gender
            tags: tags
          }, (err, authCode)!->
            if err
              console.log err
              res.status 500 .end!
            else
              authMail.send email, authCode
              passport.signin res, username, password, (err)!->
                if err
                  console.log err
                  res.status 500 .end!
                else
                  res.end 'ok'
