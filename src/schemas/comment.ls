require! ['mongoose']
ObjectId = mongoose.Schema.Types.ObjectId

CommentSchema = new mongoose.Schema {
  activity: {type: ObjectId, ref: 'Activity'},  #评论的活动
  from: {type: ObjectId, ref: 'User'},          #评论人
  to: {type: ObjectId, ref: 'User'},            #评论回复对象
  content: String,                              #评论内容                      
  meta: {
    createAt: {
      type: Date,
      default: Date.now!
    },
    updateAt: {
      type: Date,
      default: Date.now!
    }
  }
}

CommentSchema.pre 'save',(next)!->
  if @.isNew 
    @.meta.createAt = @.meta.updateAt = Date.now!
  else
    @.meta.updateAt = Date.now!
  next!

CommentSchema.statics = {
  fetch: (cb)->
    @ .find {} .sort 'meta.updateAt' .exec cb
  findById: (id, cb)->
    @ .findOne {_id: id} .exec cb
}

module.exports = CommentSchema
