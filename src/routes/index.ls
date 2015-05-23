require! {'express', Activity: '../controllers/data/activity'}
require! ['../controllers/page/index', '../controllers/page/home', '../controllers/page/detail']
require! ['../controllers/page/create', '../controllers/page/edit', '../controllers/page/host']
require! ['../controllers/page/following', '../controllers/page/joining', '../controllers/page/admin']
require! ['../controllers/page/setting']
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
  router.get '/following', (req, res)!-> res.render 'following', {
    title: '我关注的活动'
  }
  router.get '/joining', (req, res)!-> res.render 'joining', {
    title: '我参与的活动'
  }
  router.get '/admin', (req, res)!-> res.render 'admin', {
    title: '活动审核页'
  }
  router.get '/setting', is-authenticated, setting

  # 数据操作
  router.post '/s-save', is-authenticated, Activity.save
  router.delete '/host', is-authenticated, Activity.delete



