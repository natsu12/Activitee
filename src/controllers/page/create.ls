require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# create page
module.exports = (req, res)!->
  require! 'mongoose'                     # 为了写死登陆用户
  ObjectId = mongoose.Types.ObjectId('555842ce961d450f1f17307d')
  req.user = {
    _id: ObjectId
    username: 'test12'
  }
  Tag.find {}, (err, tags)->
    if err
      console.log err
    tagNames = []
    for tag in tags
      tagNames.push tag.name
    res.render 'create', {
      title: '发布活动信息'
      user: req.user
      tagNames: tagNames
    }
