require! {
  User:'../../models/user',
  Tag: '../../models/tag',
  passport: '../../passport/passport',
  path,
  multer,
  '../../imageCropper'
}

# use the hash funtion in passport
# the encrypt algorithm is MD5 indeed
hash = passport.hash

uploadAbsoluteDir = path.join __dirname, '..', '..', '..', 'upload'
avatarRelativeDir = 'avatars'

# save user information
module.exports = (req, res)!->

  uid = req.user._id
  userObj = req.user

  if req.body.type == "basic"
    console.log "updating basic info..."

    # 更新用户订阅标签
    tags = String(req.body.user.tags).split ','
    User.findById uid, (err, user)!->
      if err
        console.log err
      else
        # 更新用户名及性别
        user.username = req.body.user.username
        user.gender = req.body.user.gender

        # 1. clean all tags in the original user.tags
        # 2. push the tags in req.body.tag
        user.tags = []
        Tag.find {$or: [{name: tagName} for tagName in tags]}, (err, tags_)!->
          for tag_ in tags_
            user.tags.push tag_._id
          user.save (err, user) !-> if err then console.log err else console.log 'user tags updated!'

          # 保存用户头像
          if req.body['image-cropper-avatar-crop-x'] != undefined
            imageCropper.save req, 'avatar', uploadAbsoluteDir, avatarRelativeDir, req.user.username, (relativePath)!->
              user.avatar = relativePath
              console.log 'update user avatar succeed!'
          else
            console.log 'no need to update avatar!'

          res.redirect '/setting'

    #TODO save avatar to file if user upload a new icon


  if req.body.type == "pwd"
    console.log "updating user password..."

    User.findOne {username: req.user.username, password: hash req.body.user.pwdOriginal}, (err, user_)!->
      if user_ isnt null
        console.log "original password valid"

        User.findById uid, (err, user)!->
          if err
            console.log err
          else if req.body.user.pwdNew == req.body.user.pwdNewConfirm
            user.password = hash req.body.user.pwdNew
            user.save (err, user) !-> if err then console.log err
            console.log "update password success!"
          else
            console.log "two new password not match!"

      else
        console.log "original password invalid"

      res.redirect '/setting'

  if req.body.type == "realInfo"
    console.log "updating real info..."

    User.findById uid, (err, user)!->
      if err
        console.log err
      else
        user.real_name = req.body.user.real_name
        user.phone_num = req.body.user.phone_num
        user.qq = req.body.user.qq
        user.weixin = req.body.user.weixin
        user.save (err, user) !-> if err then console.log err else console.log 'user real info updated!'

    res.redirect '/setting'
