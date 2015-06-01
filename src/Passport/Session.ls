require! ['mongoose']

SessionSchema = new mongoose.Schema {
  username: String
}

module.exports = mongoose.model 'Session', SessionSchema
