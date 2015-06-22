require! {
  './config'
  '../mail'
  jade
  path
}

exports.send = (email, authCode)!->
  html = jade.renderFile path.join(__dirname, 'authMail.jade'), {
    host: config.host
    authCode: authCode
  }
  mail.send email, 'Activitee注册验证邮件', html
