require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}
_ = require 'underscore'

module.exports = (req, res)!->
  id = req.query.id
  
  if id
    Activity.findById id, (err, activity)!->
      User.findById req.user._id, (err, user)!->
          user.joining_acts.push id
          user.save (err, user)!->
            if err
              console.log err
          need_info = activity.need_info
          if need_info is 1
            if !user.phone_num or !user.real_name
              res.json {success: -1}
              return
          activity.joining_users.push req.user._id
          activity.save (err, activity)!->
            if err
              console.log err
            res.json {success : 1, joins : activity.joining_users.length}
