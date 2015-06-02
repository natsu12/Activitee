require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

# host page
module.exports = (req, res)!->
  require! 'mongoose'                     # 为了写死登陆用户
  ObjectId = new mongoose.Types.ObjectId('555842ce961d450f1f17307d')
  req.user = {
    _id: ObjectId
    username: 'test12'
  }
  user_id = req.user._id
  Activity.findByUser user_id, (err, activities)!->
    if err
      console.log err
    res.render 'host', {
      title: '我发布的活动'
      user: req.user
      activities: activities
    }
