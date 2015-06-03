require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}

# home page
module.exports = (req, res)!->
  require! 'mongoose'                     # 为了写死登陆用户
  ObjectId = new mongoose.Types.ObjectId('555842ce961d450f1f17307d')
  req.user = {
    _id: ObjectId
    username: 'test12'
  }

  # 获取热门标签及其活动
  (error, activities) <- Activity .find {} .populate 'host' .exec
  # 获取当前时间
  now = new Date!
  # 默认在界面显示的活动
  default-activities = []
  # 循环遍历活动获取符合时间规定的活动
  for activity in activities       # 缺点: 每次遍历全部活动，效率低
    # console.log '**********'
    if activity.time > now
      # console.log activity.title, activity.time
      default-activities.push activity
  # 对活动进行排序
  default-activities .sort activityCmp

  # 获取所有tags
  (error, tags) <- Tag .find {} .populate 'users' .exec
  # 对tags进行排序(降序)
  tags = tags .sort tagCmp
  # 输出测试
  # console.log '--------'
  # for tag in tags            
  #   continue if tag.users == null
  #   console.log tag.name, tag.users.length
  
  # 取前五个tags
  top-five-tags = new Array!
  for tag, index in tags when index < 5   # 缺点: 每次遍历全部的tag，效率低
    top-five-tags.push tag

  res.render 'home', {
    title: '活动主页'
    user: req.user
    activities: default-activities
    top-five-tags: top-five-tags
  }
  
  # 获取 我的tag ... 登录


# 比较函数-辅助
tagCmp = (tag1, tag2)->
  return 1 if tag1.users == null    # populate处理后，会产生空对象
  return -1 if tag2.users == null
  return 1 if tag1.users.length < tag2.users.length # 符号可调整
  return -1 if tag1.users.length > tag2.users.length
  return 0

# 比较函数-辅助
activityCmp = (activity1, activity2)->
  return -1 if activity1.time < activity2.time
  return 1 if activity1.time > activity2.time
  return 0
