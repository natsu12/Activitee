require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

findUserJoining = (id, cb)->
  Activity .find {} .populate({path: 'joining_users', select: {_id : 1}}) .find {joining_users : id} .sort 'time' .exec cb

# joining page
module.exports = (req, res)!->
  if !req.user
    res.redirect '/signin'
  user_id = req.user._id
  findUserJoining user_id, (err, activities)!->
    if err
      console.log err
    res.render 'joining', {
      title: '我参与的活动'
      user: req.user
      activities: activities
    }

