require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User: '../../models/user'}
_ = require 'underscore'


# save an activity
module.exports = (req, res)!->
  require! 'mongoose'                     # 为了写死登陆用户
  ObjectId = mongoose.Types.ObjectId('555842ce961d450f1f17307d')
  req.user = {
    _id: ObjectId
    username: 'test12'
  }

  id = req.body.activity._id
  activityObj = req.body.activity
  if id isnt undefined     # 已存在，更新字段
    Activity.findById id, (err, activity)!->
      if err
        console.log err
      _activity = _.extend activity, activityObj
      _activity.save (err, activity)!->
         if err
           console.log err
         res.redirect '/host'
  else                     # 不存在，新建字段
    _activity = new Activity {
      title: activityObj.title
      detail: activityObj.detail
      time: activityObj.time
      place: activityObj.place
      host: req.user._id
      host_info: activityObj.host_info
      status: 0
    }

    _activity.save (err, activity)!->
      if err
        console.log err

      res.redirect '/upload_img/' + activity._id

