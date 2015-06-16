require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# upload image page
module.exports = (req, res)!->
  id = req.params.id
  Activity .findOne {_id: id}, (err, activity)!->
    res.render 'upload_img', {
      title: '修改活动信息'
      act_id: id
      user: req.user
      activity: activity
    }
