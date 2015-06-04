require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}
_ = require 'underscore'

# update an activity
module.exports = (req, res)!->
  id = req.query.id
  if id
    conditions = {_id: id}
    update = {
      status: 1
    }
    options = {upsert:false}
    Activity.update conditions, update, options, (err)!->
      if err
        console.log err
      else
        res.json {success: 1}

