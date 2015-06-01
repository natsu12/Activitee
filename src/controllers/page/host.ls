require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

# host page
module.exports = (req, res)!->
  user_id = req.user._id
  Activity.findByUser user_id, (err, activities)!->
    if err
      console.log err
    res.render 'host', {
      title: '我发布的活动'
      user: req.user
      activities: activities
    }
