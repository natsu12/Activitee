require! '../../passport/passport'

module.exports = (req, res)!->
  # x inputs from body
  username = req.body.username
  password = req.body.password
  # sign in
  passport.signin res, username, password, (err, msg)!->
    if err
      res.status 500 .end!
    else
      res.end msg
