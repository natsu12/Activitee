require! {
  Activity:'../../models/activity',
  Tag:'../../models/tag',
  Comment:'../../models/comment',
  User:'../../models/user'
}
_ = require 'underscore'

findUserHost = (id, cb)->
   Activity .find {} .populate({path: 'host', select: {_id : 1}}) .find {host : id} .sort 'time' .exec cb

# host page
module.exports = (req, res)!->
  # 判断是否登录
  if req.user
    user_id = req.user._id
    # 找到所有发布的活动
    (error, host_act) <- Activity .find {} .populate({path: 'host', select: {_id : 1, username: 1}}) .find {host : user_id} .sort 'time' .exec
    #找到所有关注的活动
    (error, following_act) <- Activity .find {} .populate({path: 'following_users', select: {_id : 1, username: 1}}) .find {following_users : user_id} .sort 'time' .exec
    #找到所有参与的活动
    (error, joining_act) <- Activity .find {} .populate({path: 'joining_users', select: {_id : 1, username: 1}}) .find {joining_users : user_id} .sort 'time' .exec

    if error
      console.log error

    # 找到用户完整信息
    User.find-by-id req.user._id, (err, user) !->
      console.log req.user
      res.render 'host', {
        title: '我发布的活动'
        user: user
        host_act: host_act.reverse()
        following_act: following_act.reverse()
        joining_act: joining_act.reverse()
      }
  else
    res.redirect('/home')
