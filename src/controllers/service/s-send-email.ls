require! {
  User:'../../models/user',
  '../../mail/mail',
}

HOST = 'http://localhost:5000'

sendAuthMail = (email, authCode)!->
  mail.send email, 'Activitee注册验证邮件', "请点击<a href='#{HOST}/s-auth/#{authCode}'>此链接</a>完成注册验证"

module.exports = (req, res)!->
  id = req.user._id
  if id isnt undefined
    User.find-by-id id, (err, user)!->
      console.log err if err
      email = user.email
      authCode = user.auth_code
      sendAuthMail email, authCode
      res.end 'ok'