require! {
  User:'../../models/user',
  '../../authMail',
}

module.exports = (req, res)!->
  id = req.user._id
  if id isnt undefined
    User.find-by-id id, (err, user)!->
      console.log err if err
      email = user.email
      authCode = user.auth_code
      authMail.send email, authCode
      res.end 'ok'
