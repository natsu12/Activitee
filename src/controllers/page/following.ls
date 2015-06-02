require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

findUserFollowing = (id, cb)->
  Activity .find {} .populate({path: 'following_users', select: {_id : 1}}) .find {following_users : id} .sort 'time' .exec cb

# following page
module.exports = (req, res)!->
  user_id = req.user._id
  findUserFollowing user_id, (err, activities)!->
    if err
      console.log err
    res.render 'following', {
      title: '我关注的活动'
      user: req.user
      activities: activities
    }