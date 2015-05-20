require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# joining page
module.exports = (req, res)!->
  res.render 'joining', {
    title: '我参与的活动'
    user: req.user
  }
