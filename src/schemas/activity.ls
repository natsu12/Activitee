require! ['mongoose']
ObjectId = mongoose.Schema.Types.ObjectId

ActivitySchema = new mongoose.Schema {
  title: String,                                           #标题
  time: Date,                                              #活动时间
  place: String,                                           #活动地点
  host: [{type: ObjectId, ref: 'User'}],                   #发布人
  host_info: String,                                       #发布人自愿提供的信息，如：微博、微信公众号
  following_users: [{type: ObjectId, ref: 'User'}],        #已关注的用户
  joining_users: [{type: ObjectId, ref: 'User'}],          #已报名的用户
  tags: [{type: ObjectId, ref: 'Tag'}],                    #标记的tag
  detail: String                                           #活动详情
  images: [String],                                        #图片
  cover: String,                                           #封面
  need_info: Number,                                       #报名是否需要真实信息，0为不需要，1为需要
  status: Number                                           #审核状态，0为未审核，1为审核
  meta: {
    createAt: {                                            #发布时间
      type: Date,
      default: Date.now!
    },
    updateAt: {                                            #更新时间
      type: Date,
      default: Date.now!
    }
  }
}

ActivitySchema.pre 'save',(next)!->
  if @.isNew 
    @.meta.createAt = @.meta.updateAt = Date.now!
  else
    @.meta.updateAt = Date.now!
  next!

ActivitySchema.statics = {
  fetch: (cb)->
    @ .find {} .sort 'time' .exec cb
  findById: (id, cb)->
    @ .findOne {_id: id} .exec cb
  findByUser: (id, cb)->
    @ .find {host_id: id} .exec cb
  findUserFollowing: (id, cb)->
    @ .find {} .populate({path: 'following_users', select: {_id : 1}, option: {_id : id}}) .exec cb
  findUserJoining: (id, cb)->
    @ .find {} .populate({path: 'joining_users', select: {_id : 1}, option: {_id : id}}) .exec cb
}

module.exports = ActivitySchema
