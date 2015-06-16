require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User: '../../models/user'}
_ = require 'underscore'
moment = require 'moment'

# save an activity
module.exports = (req, res)!->

  id = req.body.activity._id
  activityObj = req.body.activity
  if id isnt undefined     # 已存在，更新字段
    Activity.findById id, (err, activity)!->
      if err
        console.log err
      tagNames = activityObj.tags.split ","
      Tag .find { name: { $in: tagNames } } (err, tagObjs)->
        tags = []
        for tagObj in tagObjs
          tags.push tagObj._id
        activityObj.tags = tags
        _activity = _.extend activity, activityObj
        # todo: 把活动从原有的tag中删除
        for tagObj in tagObjs
          tagObj.activities.push activity._id
          tagObj.save!
        _activity.save (err, activity)!->
           if err
             console.log err
           res.redirect '/upload_img/' + activity._id

  else                     # 不存在，新建字段
    tagNames = activityObj.tags.split ","
    Tag .find { name: { $in: tagNames } } (err, tagObjs)->
      tags = []
      for tagObj in tagObjs
        tags.push tagObj._id
      activity = new Activity {
        title: activityObj.title
        tags: tags
        detail: activityObj.detail
        time: activityObj.time
        place: activityObj.place
        host: req.user._id
        host_info: activityObj.host_info
        status: 0
      }
      for tagObj in tagObjs
        tagObj.activities.push activity._id
        tagObj.save!

      activity.save (err, activity)!->
        if err
          console.log err
        console.log "success"

      res.redirect '/upload_img/' + activity._id
