require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}
_ = require 'underscore'



# following page
module.exports = (req, res)!->
  if !req.user
    res.redirect '/signin'
  user_id = req.user._id
  act_id = req.query.act_id

  #所有关注的人
  (err, follow_users) <- User .find {} .populate({path: 'following_acts', select: {_id : 1}}) .find {following_acts : act_id} .exec
  #console.log follow_users

  #所有参与的人
  (err, join_users) <- User .find {} .populate({path: 'joining_acts', select: {_id : 1}}) .find {joining_acts : act_id} .exec
  #console.log join_users

  #本活动信息
  (err, activity) <- Activity.find-one {_id : act_id} .exec
  if err
    console.log err



  #获取page的参数
  if req.query.fpage is undefined
    following_page = 1

  else
    following_page = Math.ceil req.query.fpage
  if req.query.jpage is undefined
    joining_page = 1
  else
    joining_page = Math.ceil req.query.jpage


  # 一页最多包含多少条
  page_contain = 8
  #总页数
  all_following_page = Math.ceil follow_users.length/page_contain
  if following_page > all_following_page
    following_page = all_following_page
  if following_page < 1
    following_page = 1

  arr_following_page = []
  for i from 1 to all_following_page
    arr_following_page.push(i)

  #一页的活动
  page_following_user = []
  temp_page = 1
  temp_index = 0
  for item in follow_users
    if following_page == temp_page
      page_following_user.push item
    temp_index = (temp_index+1)%page_contain
    if temp_index == 0
      temp_page = temp_page+1
    if temp_page > following_page
      break;

  # 一页最多包含多少条
  page_contain = 8
  #总页数
  all_joining_page = Math.ceil join_users.length/page_contain
  if joining_page > all_joining_page
    joining_page = all_joining_page
  if joining_page < 1
    joining_page = 1

  arr_joining_page = []
  for i from 1 to all_joining_page
    arr_joining_page.push(i)

  #一页的活动
  page_joining_user = []
  temp_page = 1
  temp_index = 0
  for item in join_users
    if joining_page == temp_page
      page_joining_user.push item
    temp_index = (temp_index+1)%page_contain
    if temp_index == 0
      temp_page = temp_page+1
    if temp_page > joining_page
      break;


  res.render 'following', {
    title: '我关注的活动'
    user: req.user
    activity: activity
    follow_users: follow_users
    page_following_user : page_following_user
    all_following_page: all_following_page
    arr_following_page: arr_following_page
    following_page: following_page

    join_users: join_users
    page_joining_user : page_joining_user
    all_joining_page: all_joining_page
    arr_joining_page: arr_joining_page
    joining_page: joining_page
    }
