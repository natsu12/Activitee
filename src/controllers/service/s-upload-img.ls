require! {
  Activity:'../../models/activity'
  Tag:'../../models/tag'
  Comment:'../../models/comment'
  User: '../../models/user'
  '../../imageCropper'
  path
}

uploadAbsoluteDir = path.join __dirname, '..', '..', '..', 'upload'
avatarRelativeDir = 'cover'

# save a cover of an activity
module.exports = (req, res)!->
  id = req.params.id
  if id isnt undefined     # 上传图片
    Activity.findById id, (err, activity)!->
      if err
        console.log err
      cover-name = id + (new Date!).getTime! # 图片保存到本地的名字(活动id+时间戳 ==> 保证名字不冲突)
      imageCropper.save req, 'cover', uploadAbsoluteDir, avatarRelativeDir, cover-name, (relativePath)!->
        activity.cover = relativePath
        activity.save (err)!->
          if err
            res.status 500 .end!
          else
            res.end 'ok'