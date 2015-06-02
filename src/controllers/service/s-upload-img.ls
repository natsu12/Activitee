require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User: '../../models/user'}
require! ['formidable', 'fs']
COVER_UPLOAD_FOLDER = '/cover/'

# save a cover of an activity
module.exports = (req, res)!->
  # require! 'mongoose'                     # 为了写死登陆用户
  # ObjectId = mongoose.Types.ObjectId('555842ce961d450f1f17307d')
  # req.user = {
  #   _id: ObjectId
  #   username: 'test12'
  # }

  id = req.params.id
  if id isnt undefined     # 上传图片
    Activity.findById id, (err, activity)!->
      if err
        console.log err
      form = new formidable.IncomingForm!
      # form.uploadDir记录图片存放的目录
      form.uploadDir = 'bin/public' + COVER_UPLOAD_FOLDER
      form.keepExtensions = true
      newPath = ""

      # 解释请求req->获取图片文件files
      form.parse req, (err, fields, files)!->
        if err
          console.log err
        # 根据客户端图片的类型->确定图片的后缀格式
        extName = ""
        switch files.cover.type
          | 'image/pjpeg'  =>  extName = 'jpg'
          | 'image/jpeg'   =>  extName = 'jpg'
          | 'image/png'    =>  extName = 'png'
          | 'image/x-png'  =>  extName = 'png'

        # 图片保存到本地的名字
        coverName = Math.random! + '.'+ extName
        # 图片保存到本地的完整路径
        newPath = form.uploadDir + coverName
        # 
        fs.renameSync files.cover.path, newPath
        # 活动记录的图片路径
        coverPath = COVER_UPLOAD_FOLDER + coverName
        activity.cover = coverPath
        activity.save (err, activity)!->
           if err
             console.log err
        res.redirect '/host'
  else
    console.log 'failed'
