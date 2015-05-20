require! ['mongoose']
ObjectId = mongoose.Schema.Types.ObjectId

UserSchema = new mongoose.Schema {
  email: String,                                        #邮箱
  password: String,                                     #密码
  username: String,                                     #用户名
  role: String,                                         #角色
  avatar: String,                                       #头像
  real_name: String,                                    #真实姓名
  phone_num: String,                                    #联系方式
  host_acts: [{type: ObjectId, ref:'Activity'}],        #已发布的活动
  following_acts: [{type: ObjectId, ref: 'Activity'}],  #已关注的活动
  joining_acts: [{type: ObjectId, ref: 'Activity'}],    #已报名的活动
  tags: [{type: ObjectId, ref: 'Tag'}],                 #订阅的tag
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

UserSchema.pre 'save',(next)!->
  if @.isNew 
    @.meta.createAt = @.meta.updateAt = Date.now!
  else
    @.meta.updateAt = Date.now!
  next!

UserSchema.statics = {
  fetch: (cb)->
    @ .find {} .sort 'meta.updateAt' .exec cb
  findById: (id, cb)->
    @ .findOne {_id: id} .exec cb
}

module.exports = UserSchema
