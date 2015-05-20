require! ['mongoose']
ObjectId = mongoose.Schema.Types.ObjectId

CommentSchema = new mongoose.Schema {
  act_id: String,                               #评论的活动的id，用于调用save方法后redirect回当前活动的url
  from: {type: ObjectId, ref: 'User'},          #评论人
  content: String,                              #评论内容
  to: {type: ObjectId, ref: 'User'},            #回复对象，null代表回复层主
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
