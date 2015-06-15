require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# upload image page
module.exports = (req, res)!->
  id = req.params.id
  res.render 'upload_img', {
    title: '发起活动'
    act_id: id
    user: req.user
  }
