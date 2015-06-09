require! '../../passport/passport'

module.exports = (req, res)!->
  # x inputs from body
  username = req.body.username
  password = req.body.password
  # sign in
  passport.signin username, password, res, (msg)!->
    console.log msg
    res.redirect '/home'

