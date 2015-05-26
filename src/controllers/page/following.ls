require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

# following page
module.exports = (req, res)!->
  user_id = req.user._id
  Activity.findUserFollowing user_id, (err, activities)!->
    if err
      console.log err
    res.render 'following', {
      title: '我关注的活动'
      user: req.user
      activities: activities
    }