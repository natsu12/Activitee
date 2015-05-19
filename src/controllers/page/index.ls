require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# index page
module.exports = (req, res)!->
  res.render 'index'
