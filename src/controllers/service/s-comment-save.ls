require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment', User:'../../models/user'}
_ = require 'underscore'

module.exports = (req, res)!->

  type = req.query.type                 # reply or new
  if type == 'new'
    act_id = req.body.comment.activity_id
    page_number = req.query.page
    if act_id == null
      console.log "no such activity"
      return
    commentObj = req.body.comment
    _comment = new Comment {
      act_id: act_id
      from: req.user._id
      content: commentObj.content
      images: commentObj.images
      replies: []
    }

    _comment.save (err, comment)!->
      if err
        console.log err
      
      User.findById req.user._id, (err, fromUser)!->
        _comment.from = fromUser
        res.render 'comment', {
            comment : _comment
            page : page_number
        }
        
  else if type == 'reply'
    act_id = req.body.reply.activity_id
    com_id = req.body.reply.com_id
    replyObj = req.body.reply
    Comment.findById com_id, (err, comment)!->
      if err
        console.log(err)
      _reply = {
        from: req.user._id
        createAt: new Date()
        to: replyObj.to
        content: replyObj.content
      }
      comment.replies.push(_reply)
      comment.save (err, comment) !->
        if err
          console.log(err)

        User.findById req.user._id, (err, fromUser)!->
          _reply.from = fromUser

          User.findById replyObj.to, (err, toUser)!->
            _reply.to = toUser
            res.render 'reply', {
              reply: _reply
              comment: comment
            }
