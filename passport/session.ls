require! ['mongoose']

SessionSchema = new mongoose.Schema {
  username: String
  sid: String
}

module.exports = mongoose.model 'Session', SessionSchema
