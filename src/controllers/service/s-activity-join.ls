require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}
_ = require 'underscore'

module.exports = (req, res)!->
  id = req.query.id
  if id
    Activity.findById id, (err, activity)!->
        activity.joining_users.push req.user._id
        activity.save (err, activity)!->
          if err
            console.log err
          User.findById req.user._id, (err, user)!->
            if err
              console.log err
            user.joining_acts.push id
            user.save (err, user)!->
              if err
                console.log err
              res.json {success : 1, joins : activity.joining_users.length}