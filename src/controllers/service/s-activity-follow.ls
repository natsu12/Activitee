require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

module.exports = (req, res)!->
  id = req.query.id
  if id
    Activity.findById id, (err, activity)!->
        activity.following_users.push req.user._id
        activity.save (err, activity)!->
          if err
            console.log err
          res.json {success : 1, follows : activity.following_users.length}