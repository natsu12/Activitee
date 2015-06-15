require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

findUserHost = (id, cb)->
   Activity .find {} .populate({path: 'host', select: {_id : 1}}) .find {host : id} .sort 'time' .exec cb

# host page
module.exports = (req, res)!->
  user_id = req.user._id
  # 找到所有发布的活动
  (error, host_act) <- Activity .find {} .populate({path: 'host', select: {_id : 1, username: 1}}) .find {host : user_id} .sort 'time' .exec
  #找到所有关注的活动
  (error, following_act) <- Activity .find {} .populate({path: 'following_users', select: {_id : 1, username: 1}}) .find {following_users : user_id} .sort 'time' .exec
  #找到所有参与的活动
  (error, joining_act) <- Activity .find {} .populate({path: 'joining_users', select: {_id : 1, username: 1}}) .find {joining_users : user_id} .sort 'time' .exec

  if error
    console.log error

  res.render 'host', {
    title: '我发布的活动'
    user: req.user
    host_act: host_act
    following_act: following_act
    joining_act: joining_act
  }
