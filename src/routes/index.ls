require! 'express'
require! ['../controllers/page/index', '../controllers/page/home', '../controllers/page/detail']
require! ['../controllers/page/create', '../controllers/page/edit', '../controllers/page/host']
require! ['../controllers/page/following', '../controllers/page/joining', '../controllers/page/admin']
require! ['../controllers/page/setting', '../controllers/service/s-user-save']
require! ['../controllers/service/s-activity-save', '../controllers/service/s-activity-delete']
require! ['../controllers/service/s-comment-save', '../controllers/service/s-comment-delete']
require! ['../controllers/service/s-activity-follow', '../controllers/service/s-activity-join']
require! ['../controllers/page/signup', '../controllers/page/signin']
require! ['../controllers/service/s-signin', '../controllers/service/s-signup', '../controllers/service/s-signout']
require! ['../controllers/service/s-activity-save', '../controllers/service/s-activity-delete', '../controllers/service/s-auth']
router = express.Router! 

is-authenticated = (req, res, next)-> if req.is-authenticated! then next! else res.redirect '/signin'

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
  router.get '/create', is-authenticated, create
  router.get '/edit/:id', is-authenticated, edit
  router.get '/host', is-authenticated, host
  router.get '/following', is-authenticated, following
  router.get '/joining', is-authenticated, joining
  router.get '/setting', is-authenticated, setting
  router.get '/admin', is-authenticated, admin

  # 数据操作
  router.post '/s-activity-save', is-authenticated, s-activity-save
  router.get '/s-activity-delete', is-authenticated, s-activity-delete

  router.post '/s-comment-save', is-authenticated, s-comment-save
  router.get '/s-comment-delete', is-authenticated, s-comment-delete

  router.get '/s-activity-follow', is-authenticated, s-activity-follow
  router.get '/s-activity-join', is-authenticated, s-activity-join
  router.post '/s-user-save', is-authenticated, s-user-save

  router.get '/s-auth/:authCode', s-auth

