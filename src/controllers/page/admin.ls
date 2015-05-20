require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# admin page
module.exports = (req, res)!->
  res.render 'admin', {
    title: '审核活动'
    user: req.user
  }
