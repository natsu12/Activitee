require! 'express'
require! ['../controllers/page/index', '../controllers/page/home', '../controllers/page/detail']
require! ['../controllers/page/create', '../controllers/page/edit', '../controllers/page/host']
require! ['../controllers/page/following', '../controllers/page/joining', '../controllers/page/admin']
require! ['../controllers/page/setting', '../controllers/page/upload_img']
require! ['../controllers/page/signup', '../controllers/page/signin']

require! ['../controllers/service/s-activity-save', '../controllers/service/s-activity-delete', '../controllers/service/s-user-save']
require! ['../controllers/service/s-comment-save', '../controllers/service/s-comment-delete']
require! ['../controllers/service/s-activity-follow', '../controllers/service/s-activity-join']
require! ['../controllers/service/s-signin', '../controllers/service/s-signup', '../controllers/service/s-signout']
require! ['../controllers/service/s-activity-save', '../controllers/service/s-activity-delete', '../controllers/service/s-auth']
require! ['../controllers/service/s-upload-img']
require! ['../controllers/service/s-homepage-update']
require! ['../controllers/service/s-activity-admin-update']
router = express.Router! 

# is-authenticated = (req, res, next)-> if req.is-authenticated! then next! else res.redirect '/signin'

module.exports = (passport)->
  # 登陆、注册、登出
  router.post '/s-signin', s-signin
  router.post '/s-signup', s-signup
  router.get '/s-signout', s-signout

  # 页面渲染
  router.get '/signin', signin
  router.get '/signup', signup
  router.get '/', index
  router.get '/home', home
  router.get '/detail/:id', detail
  router.get '/create', create
  router.get '/upload_img/:id', upload_img
  router.get '/edit/:id', edit
  router.get '/host', host
  router.get '/following', following
  router.get '/joining', joining
  router.get '/setting', setting
  router.get '/admin', admin
  
  # 获取数据更新主页内容
  router.get '/s-homepage-update', s-homepage-update

  # 数据操作
  router.post '/s-activity-save', s-activity-save
  router.get '/s-activity-delete', s-activity-delete

  router.get '/s-activity-admin-update', s-activity-admin-update
  # 活动审核的更新路由

  router.post '/s-comment-save', s-comment-save
  router.get '/s-comment-delete', s-comment-delete

  router.get '/s-activity-follow', s-activity-follow
  router.get '/s-activity-join', s-activity-join
  router.post '/s-user-save', s-user-save

  router.get '/s-auth/:authCode', s-auth

  router.post '/s-upload-img/:id', s-upload-img


