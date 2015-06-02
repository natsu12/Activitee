require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User: '../../models/user'}
require! ['formidable', 'fs']
COVER_UPLOAD_FOLDER = 'cover/'

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
      form.uploadDir = "upload/" + COVER_UPLOAD_FOLDER
      form.keepExtensions = true
      newPath = ""

      form.parse req, (err, fields, files)!->
        if err
          console.log err
        extName = ""
        switch files.cover.type
          | 'image/pjpeg'  =>  extName = 'jpg'
          | 'image/jpeg'   =>  extName = 'jpg'
          | 'image/png'    =>  extName = 'png'
          | 'image/x-png'  =>  extName = 'png'

        coverName = Math.random! + '.'+ extName
        newPath = form.uploadDir + coverName
        coverPath = COVER_UPLOAD_FOLDER + coverName
        fs.renameSync files.cover.path, newPath
        activity.cover = coverPath
        activity.save (err, activity)!->
           if err
             console.log err
        res.redirect '/host'
  else
    console.log 'failed'