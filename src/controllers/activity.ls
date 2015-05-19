require! {Activity:'../models/activity', Tag:'../models/tag', Comment:'../models/comment'}
_ = require 'underscore'

# home page
exports.home = (req, res)!->
  Activity.fetch (err, activities)!->
    if err
      console.log err
    res.render 'home', {
      title: '活动主页'
      user: req.user
      activities: activities
    }

# detail page
exports.detail = (req, res)!->
  id = req.params.id
  Activity.findById id, (err, activity)!->
    res.render 'detail', {
      title: activity.title + '详情'
      user: req.user
      activity: activity
    }

# create page
exports.create = (req, res)!->
  res.render 'create', {
    title: '发布活动信息'
    user: req.user
  }

# edit page
exports.edit = (req, res)!->
  id = req.params.id
  if id
    Activity.findById id, (err, activity)!->
      if err
        console.log err
      res.render 'edit', {
        title: '修改活动信息'
        user: req.user,
        activity: activity
      }

# host page
exports.host = (req, res)!->
  user_id = req.user._id
  Activity.findByUser user_id, (err, activities)!->
    if err
      console.log err
    res.render 'host', {
      title: '我发布的活动'
      user: req.user
      activities: activities
    }

# save an activity
exports.save = (req, res)!->
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
      summary: activityObj.summary
      time: activityObj.time
      place: activityObj.place
      host: req.user.username
      host_id: req.user._id
      people_num: activityObj.people_num
      tags: activityObj.tags
      images: activityObj.images
      cover: activityObj.cover
      status: 0
    }

    _activity.save (err, activity)!->
      if err
        console.log err
      res.redirect '/host'