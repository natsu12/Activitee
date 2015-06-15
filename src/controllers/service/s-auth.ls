require! {User: '../../models/user'}

module.exports = (req, res)!->
  authCode = req.params.authCode
  User.update {auth_code: authCode}, {$set: {authenticated: 1}}, (err, num)!->
    if err
      console.log err
      res.status 500 .end!
    else if num > 0
      res.end 'ok'
    else
      res.end 'bad auth code'
