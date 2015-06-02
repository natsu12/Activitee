require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# upload image page
module.exports = (req, res)!->
  # require! 'mongoose'                     # 为了写死登陆用户
  # ObjectId = mongoose.Types.ObjectId('555842ce961d450f1f17307d')
  # req.user = {
  #   _id: ObjectId
  #   username: 'test12'
  # }
  id = req.params.id
  res.render 'upload_img', {
    title: '上传封面'
    act_id: id
  }
