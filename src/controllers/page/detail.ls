require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# detail page
module.exports = (req, res)!->
  id = req.params.id
  Activity.findById id, (err, activity)!->
    res.render 'detail', {
      title: activity.title + '详情'
      user: req.user
      activity: activity
    }
