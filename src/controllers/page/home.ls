require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}
# home page
module.exports = (req, res)!->
  # 获取热门标签及其活动
  (error, activities) <- Activity .find {} .populate 'host' .exec
  # 获取当前时间
  now = new Date!
  # 默认在界面显示的活动
  default-activities = []
  # 循环遍历活动获取符合时间规定的活动
  for activity in activities       # 缺点: 每次遍历全部活动，效率低
    if activity.time > now
      default-activities.push activity
  # 对活动进行排序
  default-activities .sort activity-cmp

  # 获取所有tags
  (error, tags) <- Tag .find {} .populate 'users' .exec

  # 对tags进行排序(降序)
  tags = tags .sort tag-cmp
  
  # 检查是否登录
  id = req.user._id if req.user isnt undefined

  (error, user) <- User .find-one { _id : id } .populate 'tags' .exec
  # 取前五个tags
  hot-tags = []
  my-tags = []
  # 热门tags的数量限制
  hot-tags-num = 15

  # 获取 我的tags ... 登录
  if user isnt null # 如果登录
    # 获取关注人数最多的前五个我订阅的tags
    my-tags = user.tags
    my-tags.sort tag-cmp
    my-tags-ids = []
    for tag in my-tags
      my-tags-ids.push tag._id.to-string!
    # 获取热门tags(受我订阅的tags的影响)
    count = 0
    for tag in tags   # 缺点: 每次遍历全部的tag，效率低
      if (my-tags-ids.index-of tag._id.to-string!) == -1
        hot-tags.push tag
        count = count + 1
        break if count >= hot-tags-num
  else  # 未登录
    hot-tags = tags.slice 0, hot-tags-num

  res.render 'home', {
    title: '活动主页'
    user: req.user
    activities: default-activities
    hot-tags: hot-tags
    my-tags: my-tags
  }


# 比较函数-辅助
tag-cmp = (tag1, tag2)->
  return 1 if tag1.users == null    # populate处理后，会产生空对象
  return -1 if tag2.users == null
  return 1 if tag1.users.length < tag2.users.length # 符号可调整
  return -1 if tag1.users.length > tag2.users.length
  return 0

# 比较函数-辅助
activity-cmp = (activity1, activity2)->
  return -1 if activity1.time < activity2.time
  return 1 if activity1.time > activity2.time
  return 0
