require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}
_ = require 'underscore'

module.exports = (req, res)!->
  id = req.query.id
  if id
    Activity.findById id, (err, activity)!->
        index = activity.joining_users.indexOf req.user._id
        if index > -1
          activity.joining_users.splice(index, 1)
        activity.save (err, activity)!->
          if err
            console.log err
          res.json {success : 1, joins : activity.joining_users.length}

  if id
    User.findById req.user._id, (err, user)!->
        index = user.joining_acts.indexOf id
        if index > -1
          user.joining_acts.splice(index, 1)
          console.log 'delete'
        user.save (err, user)!->
          if err
            console.log err