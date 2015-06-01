require! {'../../Passport/Passport'}

passport = new Passport

module.exports = (req, res)!->
  passport.signout !->
    'ok'
