require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}

# create page
module.exports = (req, res)!->
  if !req.user
    res.redirect '/signin'
  uid = req.user._id
  User.findById uid, (err, user)!->
    if err
        console.log err
    # if !user.real_name || !user.phone_num || !user.authenticated
    #   res.redirect '/unreal'
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
