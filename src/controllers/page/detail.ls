require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}

# detail page
module.exports = (req, res)!->
  require! 'mongoose'                     # 为了写死登陆用户
  ObjectId = new mongoose.Types.ObjectId('555842ce961d450f1f17307d')
  req.user = {
    _id: ObjectId
    username: 'test12'
  }
  id = req.params.id
  Activity .findOne {_id: id} .populate({path:'host following_users joining_users tags'}) .exec (err, activity)!->
    if err
      console.log (err)
    Comment. find {act_id: id} .populate({path:'from replies.from replies.to'}) .exec (err, comments)!->
      if err
        console.log (err)
      # activity.host_info =  activity.host_info.replace(/\n/g, "<br>");
      res.render 'detail', {
        title: activity.title + '详情'
        user: req.user
        activity: activity
        comments: comments
      }