require! {'express', Activity: '../controllers/activity'}
router = express.Router! 

is-authenticated = (req, res, next)-> if req.is-authenticated! then next! else res.redirect '/signin'

module.exports = (passport)->
  router.get '/', (req, res)!-> res.render 'index', message: req.flash 'message'

  router.post '/login', passport.authenticate 'login', {
    success-redirect: '/home', failure-redirect: '/', failure-flash: true
  }

  router.get '/signup', (req, res)!-> res.render 'register', message: req.flash 'message'

  router.post '/signup', passport.authenticate 'signup', {
    success-redirect: '/home', failure-redirect: '/signup', failure-flash: true
  }

  router.get '/home', Activity.home
  router.get '/detail/:id', Activity.detail
  router.get '/create', is-authenticated, Activity.create
  router.get '/edit/:id', is-authenticated, Activity.edit
  router.post '/s-save', is-authenticated, Activity.save


  router.get '/following', (req, res)!-> res.render 'following', {
    title: '我关注的活动'
  }
  router.get '/joining', (req, res)!-> res.render 'joining', {
    title: '我参与的活动'
  }
  router.get '/host', (req, res)!-> res.render 'host', {
    title: '我发布的活动'
  }
  router.get '/admin', (req, res)!-> res.render 'admin', {
    title: '活动审核页'
  }
  router.get '/signin', (req, res)!-> res.render 'signin', {
    message: req.flash 'message'
  }


  router.get '/signout', (req, res)!-> 
    req.logout!
    res.redirect '/'

