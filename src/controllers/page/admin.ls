require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

findUserHost = (id, cb)->
   Activity .find {} .populate({path: 'host', select: {_id : 1}}) .find {host : id, status : 0} .sort 'meta' .exec cb

# admin page
module.exports = (req, res)!->
  require! 'mongoose'                     # 为了写死登陆用户, 仿host.ls
  ObjectId = new mongoose.Types.ObjectId('555842ce961d450f1f17307d')
  req.user = {
    _id: ObjectId
    username: 'test12'
    role: 1
  }
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
