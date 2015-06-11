require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

module.exports = (req, res)!->
  id = req.query.id
  if id
    Activity.findById id, (err, activity)!->
        index = activity.following_users.indexOf req.user._id
        if index > -1
          activity.following_users.splice(index, 1)
          console.log 'delete'
        activity.save (err, activity)!->
          if err
            console.log err
          res.json {success : 1, joins : activity.following_users.length}
