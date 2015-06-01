require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}

# home page
module.exports = (req, res)!->
<<<<<<< HEAD
  # populate 扩展测试
  # Activity .findOne {place: '逸夫楼200'} .populate 'host' .exec (error, activity)->
  #   console.log activity
  
  # 添加标签数据
  # (error, users) <- User .find {}
  # for i from 6 to 10
  #   tag = new Tag!
  #   tag.name = "tag" + i
  #   for j from 1 to 1
  #     tag.users.push users[0]
  #     tag.save!
  # 提交测试
  # res.render 'home', {
  #   title: '活动主页'
  #   user: req.user
  #   activities: activities
  # }

  (error, users) <- User .find {}
  console.log users.length
  (error, activities) <- Activity .find {}
  # 获取热门标签及其活动
  # 后期：取出Tag的同时排序并且取前五
  # 获取所有tags
  (error, tags) <- Tag .find {}
  # tags[0].users.push users[0]
  # tags[0].users.push users[1]
  # tags[1].users.push users[0]
  console.log '-------'
  for tag in tags
    console.log tag.name, tag.users.length
  # 对tags进行排序(降序)
  tags = tags .sort tagCmp
  console.log '--------'
  for tag in tags
    console.log tag.name, tag.users.length
  
  # 取前五个tags
  top-five-tags = new Array!
  for tag, index in tags when index < 5
    top-five-tags.push tag

  res.render 'home', {
    title: '活动主页'
    user: req.user
    activities: activities
    top-five-tags: top-five-tags
  }

  # 获取热门活动

  # 获取 我的tag ... 登录


# 比较函数-辅助
tagCmp = (tag1, tag2)->
  return tag1.users.length < tag2.users.length # 符号可调整

=======
  Activity .find {} .sort 'time' .populate 'host' .exec (err, activities)!->
    if err
      console.log err
    res.render 'home', {
      title: '活动主页'
      user: req.user
      activities: activities
    }
>>>>>>> f16212c81b3c511e58a2cea2f907eba887dce0ac
