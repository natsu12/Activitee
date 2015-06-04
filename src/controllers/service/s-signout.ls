require! {'../../passport/passport'}

module.exports = (req, res)!->
  passport.signout res, !->
    res.redirect '/home'
