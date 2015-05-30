require! 'express'
require! ['../controllers/page/index', '../controllers/page/home', '../controllers/page/detail']
require! ['../controllers/page/create', '../controllers/page/edit', '../controllers/page/host']
require! ['../controllers/page/following', '../controllers/page/joining', '../controllers/page/admin']
require! ['../controllers/page/setting', '../controllers/page/signup', '../controllers/page/signin']
require! ['../controllers/service/s-signin', '../controllers/service/s-signup', '../controllers/service/s-signout']
require! ['../controllers/service/s-activity-save', '../controllers/service/s-activity-delete']
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
