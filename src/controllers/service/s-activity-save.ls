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
      Tag .find { _id: { $in: activityObj.tags } } (err, oldTagObjs)!->
        # 把后来没有活动从原有的tag中删除，把原有的活动从新增列表中删除(避免重复插入)
        for oldTagObj in oldTagObjs
          if tagNames.indexOf oldTagObj.name == -1
            oldTagObj.activities.splice (oldTagObj.activities.indexOf activity._id), 1
            oldTagObj.save!
          else
            tagNames.splice (tagNames.indexOf activity.oldTagObj.name), 1
        Tag .find { name: { $in: tagNames } } (err, tagObjs)!->
          if err
            console.log err
          tags = []
          for tagObj in tagObjs
            tags.push tagObj._id
          activityObj.tags = tags
          _activity = _.extend activity, activityObj
          for tagObj in tagObjs
            tagObj.activities.push activity._id
            tagObj.save!
            tagNames.splice (tagNames.indexOf tagObj.name), 1
          # 新创建tag
          for notExistTagName in tagNames
            newTag = new Tag {
              name: notExistTagName
              activities: [activity._id]
            }
            newTag.save!
            _activity.tags.push newTag._id
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
        tagNames.splice (tagNames.indexOf tagObj.name), 1
      activity = new Activity {
        title: activityObj.title
        tags: tags
        detail: activityObj.detail
        time: activityObj.time
        place: activityObj.place
        lng: activityObj.lng
        lat: activityObj.lat
        host: req.user._id
        host_info: activityObj.host_info
        status: 0
      }
      # 新创建tag
      for notExistTagName in tagNames
        newTag = new Tag {
          name: notExistTagName
          activities: [activity._id]
        }
        newTag.save!
        activity.tags.push newTag._id
      for tagObj in tagObjs
        tagObj.activities.push activity._id
        tagObj.save!
      activity.save (err, activity)!->
        if err
          console.log err
        console.log "success"

      res.redirect '/upload_img/' + activity._id
