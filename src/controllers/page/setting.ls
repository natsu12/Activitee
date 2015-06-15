require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User: '../../models/user'}

# setting page
module.exports = (req, res)!->

  id = req.user._id

  # 必须先获取用户详细信息，再渲染
  if id isnt undefined
    User.find-by-id id, (err, user)!->
      console.log err if err

      console.log user
      # 活取所有可选的tags
      Tag.find {}, (err, tags)->
        console.log 'query available tags failed!' if err

        tagNames = [tag.name for tag in tags]

        if user.tags.length
        # 获取用户订阅的标签的名称列表
          Tag.find {$or: [{_id: id} for id in user.tags]}, (err, tags)!->
            bookedTagNames = [tag.name for tag in tags]
            res.render 'setting', {
              title: '个人设置'
              user: user
              tagNames: tagNames
              bookedTagNames: bookedTagNames
            }
        else
          res.render 'setting', {
            title: '个人设置'
            user: user
            tagNames: tagNames
            bookedTagNames: []
          }

