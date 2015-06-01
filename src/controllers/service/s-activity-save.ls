require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
require! ['formidable', 'fs']
COVER_UPLOAD_FOLDER = '/cover/'
_ = require 'underscore'

# save an activity
module.exports = (req, res)!->
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
    form = new formidable.IncomingForm!
    form.uploadDir = 'public' + COVER_UPLOAD_FOLDER
    form.keepExtensions = true

    form.parse req, (err, fields, files)!->
      if err
        console.log err
        
      _activity = new Activity {
        title: activityObj.title
        summary: activityObj.summary
        time: activityObj.time
        place: activityObj.place
        host: req.user._id
        people_num: activityObj.people_num
        tags: activityObj.tags
        images: activityObj.images
        cover: activityObj.cover
        status: 0
      }

      _activity.save (err, activity)!->
        if err
          console.log err
        console.log "success"
        res.redirect '/host'

