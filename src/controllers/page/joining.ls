require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

# joining page
module.exports = (req, res)!->
  user_id = req.user._id
  Activity.findUserJoining user_id, (err, activities)!->
    if err
      console.log err
    res.render 'joining', {
      title: '我参与的活动'
      user: req.user
      activities: activities
    }

