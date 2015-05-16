require! ['mongoose']
ObjectId = mongoose.Schema.Types.ObjectId

TagSchema = new mongoose.Schema {
  name: String,                                   #tag名称
  activities: [{type: ObjectId, ref: 'Activity'}] #标记了这个tag的活动
  users: [{type: ObjectId, ref: 'User'}]          #订阅了这个tag的用户
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

TagSchema.pre 'save',(next)!->
  if @.isNew 
    @.meta.createAt = @.meta.updateAt = Date.now!
  else
    @.meta.updateAt = Date.now!
  next!

TagSchema.statics = {
  fetch: (cb)->
    @ .find {} .sort 'meta.updateAt' .exec cb
  findById: (id, cb)->
    @ .findOne {_id: id} .exec cb
}

module.exports = TagSchema
