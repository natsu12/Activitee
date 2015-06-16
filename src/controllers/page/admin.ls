require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}

findUserHost = (id, cb)->
   Activity .find {status : 0} .populate({path:'tags'}) .sort 'time' .exec cb

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
    # 获取跳转至的页面
    now_page = Math.ceil req.query.page

    # 一页最多包含多少条
    page_contain = 5

    page_num = activities.length
    all_page = Math.ceil page_num/page_contain

    if now_page > all_page
      now_page = all_page
    if now_page < 1
      now_page = 1

    select_activities = []
    temp_page = 1
    temp_index = 0
    for activity in activities
      if now_page == temp_page
        select_activities.push activity
      temp_index = (temp_index+1)%page_contain
      if temp_index == 0
        temp_page = temp_page+1

    res.render 'admin', {
      title: '活动审核'
      now_page: now_page
      all_page: all_page
      user: req.user
      activities: select_activities
    }
