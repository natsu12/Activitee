require! ['mongoose']
ObjectId = mongoose.Schema.Types.ObjectId

ActivitySchema = new mongoose.Schema {
  id: String,                
  title: String,                                           #标题
  summary: String,                                         #简介
  time: Date,                                              #活动时间
  place: String,                                           #活动地点
  host: String,                                            #发布人
  host_id: String,                                         #发布人id
  people_num: Number,                                      #活动人数
  following_users: [{type: ObjectId, ref: 'User'}],        #已关注的用户
  joining_users: [{type: ObjectId, ref: 'User'}],          #已报名的用户
  tags: [{type: ObjectId, ref: 'Tag'}],                    #标记的tag
  images: [String],                                        #图片
  cover: String,                                           #封面
  need_info: Number,                                       #报名是否需要真实信息，0为不需要，1为需要
  status: Number                                           #审核状态，0为未审核，1为审核
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
}

module.exports = ActivitySchema
