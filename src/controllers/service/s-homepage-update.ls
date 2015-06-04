require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
Jade = require 'jade'

module.exports = (req, res)!->

  # 获取活动
  option = req.query
  time-bucket = option.time-bucket
  tags = option.tags
  order-by = option.order-by
  page-num = parse-int option.page-num
  now = new Date!

  (error, activities) <-! Activity .find {}
  # 根据option的条件筛选
  result-activities = []
  for activity in activities
    continue if time-bucket is 'future' and activity.time < now
    continue if time-bucket is 'past' and activity.time > now
    if tags is [] or tags is undefined
      result-activities.push activity
    else
      for tag in activity.tags
        if (tags.index-of tag) != -1
          result-activities.push activity
          break

  # 排序
  result-activities = result-activities .sort activity-cmp-by-time-if-future-or-all if order-by is 'time' and (time-bucket is 'future' or time-bucket is 'all')
  result-activities = result-activities .sort activity-cmp-by-time-if-past if order-by is 'time' and time-bucket is 'past'
  result-activities = result-activities .sort activity-cmp-by-attention if order-by is 'attention'
  result-activities = result-activities .sort activity-cmp-by-participation if order-by is 'participation'

  # 分页
  page-result-activities = []
  num-each-page = 12
  from-index = (page-num - 1) * num-each-page
  to-index = page-num * num-each-page - 1
  for index from from-index to to-index
    break if result-activities[index] is undefined
    page-result-activities.push result-activities[index]


  # 制造活动模板
  (error, activities-template)<-! Jade.renderFile './src/views/activities-template.jade', { activities: page-result-activities }
  console.log error if error

  # 返回结果到homepage
  res.json {
    activities-template: activities-template
    activities: page-result-activities
  }

activity-cmp-by-time-if-future-or-all = (activity1, activity2)->
  return 1 if activity1.time > activity2.time
  return -1 if activity1.time < activity2.time
  return 0

activity-cmp-by-time-if-past = (activity1, activity2)->
  return 1 if activity1.time < activity2.time
  return -1 if activity1.time > activity2.tim2
  return 0

activity-cmp-by-attention = (activity1, activity2)->
  return 1 if activity1.following_users.length < activity2.following_users.length
  return -1 if activity1.following_users.length > activity2.following_users.length
  return 0

activity-cmp-by-participation = (activity1, activity2)->
  return 1 if activity1.joining_users.length < activity2.joining_users.length
  return -1 if activity1.joining_users.length > activity2.joining_users.length
  return 0
