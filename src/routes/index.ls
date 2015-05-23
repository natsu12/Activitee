require! 'express'
require! ['../controllers/page/index', '../controllers/page/home', '../controllers/page/detail']
require! ['../controllers/page/create', '../controllers/page/edit', '../controllers/page/host']
require! ['../controllers/page/following', '../controllers/page/joining', '../controllers/page/admin']
require! ['../controllers/page/setting']
require! ['../controllers/service/s-activity-save', '../controllers/service/s-activity-delete']
router = express.Router! 

is-authenticated = (req, res, next)-> if req.is-authenticated! then next! else res.redirect '/signin'

module.exports = (passport)->
  # 登陆、注册、登出
  router.post '/login', passport.authenticate 'login', {
    success-redirect: '/home', failure-redirect: '/', failure-flash: true
  }
  router.get '/signup', (req, res)!-> res.render 'register', message: req.flash 'message'
  router.post '/signup', passport.authenticate 'signup', {
    success-redirect: '/home', failure-redirect: '/signup', failure-flash: true
  }
  router.get '/signin', (req, res)!-> res.render 'signin', {
    message: req.flash 'message'
  }
  router.get '/signout', (req, res)!-> 
    req.logout!
    res.redirect '/'

  # 页面渲染
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



