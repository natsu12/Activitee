require! {'./Session'}

require! {User: '../models/user', MD5}
DEFAULT_USER = User
DEFAULT_HASH = MD5
DEFAULT_SID_GENERATOR = !-> Math.random!toString!

Passport = (User, hash, sidGenerator)->
  # default args
  User = User or DEFAULT_USER
  hash = hash or DEFAULT_HASH
  sidGenerator = sidGenerator or DEFAULT_SID_GENERATOR
  
  # middleware for auth
  @auth = (req, res, next)!->
    # x sid from cookies
    sid = req.cookies.sid
    if sid
      # find session by sid
      Session.find sid: sid, (err, docs)!->
        if err
          'handle error'
        else
          session = docs[0]
          if session
            # store username
            req.username = session.username
    next!
  
  # async func for signin
  @signin = (username, password, res, cb)!->
    User.find username: username, (err, docs)!->
      if err
        'handle error'
      else
        user = docs[0]
        # ok
        if user and user.password == hash(password)
          res.cookie 'sid', sidGenerator!
          cb 'ok'
        # fail
        else
          cb 'bad username/password'

  # async func for signout
  @signout = (cb)!->
    # x sid from cookies
    sid = req.cookies.sid
    if sid
      # destroy session by sid
      Session.remove sid: sid, (err)!->
        if err
          'handle error'
        else
          cb!

module.exports = Passport
