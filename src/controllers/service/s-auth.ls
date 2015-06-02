require! {User: '../../models/user'}

module.exports = (req, res)!->
  authCode = req.params.authCode
  User.find authCode: authCode, (err, docs)!->
    if err
      'handle error'
    else
      user = docs[0]
      if user
        User.update {authCode: authCode}, {$set: {authenticated: 1}}, (err)!->
          if err
            'handle error'
          else
            res.end 'ok'
      else
        'handle error'
