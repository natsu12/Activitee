require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# setting page
module.exports = (req, res)!->
  res.render 'setting', {
    title: '个人设置'
    user: req.user
  }
