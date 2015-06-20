require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

findUserHost = (id, cb)->
   Activity .find {} .populate({path: 'host', select: {_id : 1}}) .find {host : id} .sort 'time' .exec cb

# host page
module.exports = (req, res)!->
  if !req.user
    res.redirect '/signin'
  user_id = req.user._id

  # 找到所有发布的活动
  (error, host_act) <- Activity .find {} .populate({path: 'host', select: {_id : 1, username: 1}}) .find {host : user_id} .sort 'time' .exec

  #找到所有关注的活动
  (error, following_act) <- Activity .find {} .populate({path: 'following_users', select: {_id : 1, username: 1}}) .find {following_users : user_id} .sort 'time' .exec

  #找到所有参与的活动
  (error, joining_act) <- Activity .find {} .populate({path: 'joining_users', select: {_id : 1, username: 1}}) .find {joining_users : user_id} .sort 'time' .exec


  #确定是那种活动1，2，3（默认1）
  act_type = 1

  #获取page的参数
  if req.query.hpage is undefined
    host_page = 1
  else
    host_page = Math.ceil req.query.hpage
    act_type = 3
  if req.query.fpage is undefined
    following_page = 1
  else
    following_page = Math.ceil req.query.fpage
    act_type = 1
  if req.query.jpage is undefined
    joining_page = 1
  else
    joining_page = Math.ceil req.query.jpage
    act_type = 2


  # 一页最多包含多少条
  page_contain = 5

  #总页数
  all_host_page = Math.ceil host_act.length/page_contain
  if host_page > all_host_page
    host_page = all_host_page
  if host_page < 1
    host_page = 1

  arr_host_page = []
  for i from 1 to all_host_page
    arr_host_page.push(i)

  #一页的活动
  page_host_act = []
  temp_page = 1
  temp_index = 0
  for activity in host_act.reverse()
    if host_page == temp_page
      page_host_act.push activity
    temp_index = (temp_index+1)%page_contain
    if temp_index == 0
      temp_page = temp_page+1
    if temp_page > host_page
      break;

  #总页数
  all_following_page = Math.ceil following_act.length/page_contain
  if following_page > all_following_page
    following_page = all_following_page
  if following_page < 1
    following_page = 1

  arr_following_page = []
  for i from 1 to all_following_page
    arr_following_page.push(i)

  #一页的活动
  page_following_act = []
  temp_page = 1
  temp_index = 0
  for activity in following_act.reverse()
    if following_page == temp_page
      page_following_act.push activity
    temp_index = (temp_index+1)%page_contain
    if temp_index == 0
      temp_page = temp_page+1
    if temp_page > following_page
      break;

  #总页数
  all_joining_page = Math.ceil joining_act.length/page_contain
  if joining_page > all_joining_page
    joining_page = all_joining_page
  if joining_page < 1
    joining_page = 1

  arr_joining_page = []
  for i from 1 to all_joining_page
    arr_joining_page.push(i)

  #一页的活动
  page_joining_act = []
  temp_page = 1
  temp_index = 0
  for activity in joining_act.reverse()
    if joining_page == temp_page
      page_joining_act.push activity
    temp_index = (temp_index+1)%page_contain
    if temp_index == 0
      temp_page = temp_page+1
    if temp_page > joining_page
      break;

  if error
    console.log error

  res.render 'host', {
    title: '我发布的活动'
    user: req.user
    act_type: act_type
    host_act: page_host_act
    host_act_length: host_act.length
    host_page: host_page
    arr_host_page: arr_host_page

    following_act: page_following_act
    following_act_length: following_act.length
    following_page: following_page
    arr_following_page: arr_following_page

    joining_act: page_joining_act
    joining_act_length: joining_act.length
    joining_page: joining_page
    arr_joining_page: arr_joining_page
  }
