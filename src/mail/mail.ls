require! {
  nodemailer
  './config'
}

transport = nodemailer.createTransport 'SMTP',
  host: config.host
  auth:
    greetingTimeout: config.timeout
    connectionTimeout: config.timeout
    socketTimeout: config.timeout
    user: config.user
    pass: config.pass

!function send addr, subject, html
  options =
    from: config.user
    to: addr
    subject: subject
    html: html

  retry = 0

  !function _send
    console.log "mailing to #{addr}.."
    transport.sendMail options, cb
  
  !function cb err, res
    if err
      console.log err
      if ++retry > config.retry
        console.log 'retry exceeded. stop mailing.'
      else
        console.log 'retry.'
        _send!
    else
      console.log "mailed to #{addr}."
      console.log res.message
      transport.close!

  _send!

module.exports =
  send: send
