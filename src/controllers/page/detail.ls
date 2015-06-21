require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}

# detail page
module.exports = (req, res)!->
  id = req.params.id
  Activity .findOne {_id: id} .populate({path:'host following_users joining_users tags'}) .exec (err, activity)!->
    if err
      console.log (err)
    Comment. find {act_id: id} .sort 'meta.createAt' .populate({path:'from replies.from replies.to'}) .exec (err, comments)!->
      if err
        console.log (err)
      console.log comments
      res.render 'detail', {
        title: activity.title + '详情'
        user: req.user
        activity: activity
        comments: comments
      }