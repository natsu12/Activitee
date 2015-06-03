require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

# update an activity
module.exports = (req, res)!->
  id = req.query.id
  if id
    Activity.remove {_id: id} (err)!->
      if err
        console.log err
      else
        res.json {success: 1}

