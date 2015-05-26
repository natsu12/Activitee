require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

# delete an comment
module.exports = (req, res)!->
  id = req.query.id
  if id
    Comment.remove {_id: id} (err)!->
      if err
        console.log err
      res.redirect '/host'