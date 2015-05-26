require! ['mongoose']
ObjectId = mongoose.Schema.Types.ObjectId

CommentSchema = new mongoose.Schema {
  act_id: String,                                #评论的活动的id，通过此id查找到属于这个活动的评论
  from: {type: ObjectId, ref: 'User'},           #评论人
  content: String,                               #评论内容
  images: [String],                              #评论图片
  replies: [{
    from: {type: ObjectId, ref: 'User'},         #楼中楼回复人
    createAt: Date,                              #楼中楼回复时间
    to: {type: ObjectId, ref: 'User'},           #楼中楼回复对象，null代表回复主评论
    content: String                              #楼中楼内容
  }],     
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
  findByActId: (id, cb)->
    @ .find {act_id: id} .exec cb
}

module.exports = CommentSchema
