require! '../../Passport/Passport'

passport = new Passport

module.exports = (req, res)!->
  # x inputs from body
  username = req.body.username
  password = req.body.password
  # sign in
  passport.signin username, password, (msg)!->
    res.end msg
