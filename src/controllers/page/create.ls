require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# create page
module.exports = (req, res)!->
  req.user = {
    _id: 123456
    username: "软件学院学生会"
  }
  res.render 'create', {
    title: '发布活动信息'
    user: req.user
  }
