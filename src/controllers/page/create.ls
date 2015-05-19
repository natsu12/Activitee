require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# create page
module.exports = (req, res)!->
  res.render 'create', {
    title: '发布活动信息'
    user: req.user
  }
