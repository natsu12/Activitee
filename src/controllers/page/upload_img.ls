require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# upload image page
module.exports = (req, res)!->
  id = req.params.id
  res.render 'upload_img', {
    title: '上传封面'
    act_id: id
  }
