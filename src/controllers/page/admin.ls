require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

findUserHost = (id, cb)->
   Activity .find {} .populate({path: 'host', select: {_id : 1}}) .find {host : id, status: 0} .sort 'time' .exec cb

# admin page
module.exports = (req, res)!->
  user_id = req.user._id
  findUserHost user_id, (err, activities)!->
    # console.log activities
    if err
      console.log err
    res.render 'admin', {
      title: '审核活动'
      user: req.user
      activities: activities
    }
