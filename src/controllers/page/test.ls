require! {'../../passport/passport'}

module.exports = (req, res)!->
  console.log '2'
  if req.user
    res.render 'log', msg: req.user.username
  else
    username = 'mchcylh'
    password = 'mchcylh'
    passport.signin username, password, res, (msg)!->
      if msg == 'ok'
        res.render 'log', msg: 'signed in'
      else
        res.render 'log', msg: 'failed'
