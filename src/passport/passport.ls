require! {MD5, Session: './session', User: '../models/user'}

module.exports = do ->
  sidGenerator = -> Math.random!toString!
  
  # hash func for password
  hash = MD5

  # async func for signin
  signin = (username, password, res, cb)!->
    console.log hash password
    User.find {username: username, password: hash password}, (err, docs)!->
      if err
        console.log err
      else
        # true username&password
        if docs[0]
          sid = sidGenerator!
          res.cookie 'sid', sid
          Session.create {sid: sid, username: username}, (err)!->
            if err
              console.log err
            else
              cb 'ok'
        # bad username/password
        else
          cb 'bad username/password'
          
  # async func for signout
  signout = (res, cb)!->
    res.cookie 'sid', '', expires: new Date(Date.now! - 1)
    cb 'ok'

  # middleware for auth
  auth = (req, res, next)!->
    sid = req.cookies.sid
    if sid
      Session.find sid: sid, (err, docs)!->
        if err
          console.log err
        else
          session = docs[0]
          if session
            username = session.username
            User.find username: username, (err, docs)!->
              if err
                console.log err
              else
                user = docs[0]
                if user
                  req.user = {
                    _id: user._id
                    username: user.username
                    role: user.role
                  }
                  next!
    else
      next!
  
  return {
    hash: hash
    signin: signin
    signout: signout
    auth: auth
  }
