require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# edit page
module.exports = (req, res)!->
  id = req.params.id
  if id
    Activity.findById id, (err, activity)!->
      if err
        console.log err
        
      res.render 'edit', {
        title: '修改活动信息'
        user: req.user
        activity: activity
      }

