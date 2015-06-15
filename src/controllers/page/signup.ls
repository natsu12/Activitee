require! {
  Tag: '../../models/tag'
}

toArray = (arrayLike)-> return [].map.call arrayLike, (item)-> item.toObject!

getTags = (cb)!->
  Tag.find {}, {_id: 0, meta: 0, activities: 0}, (err, tags)!->
    if err
      cb err
    else
      tags = toArray(tags)
      # count users
      tags.forEach (tag)!-> tag.userCount = tag.users.length
      # remove users field
      tags.forEach (tag)!-> delete tag.users
      # sort by user count(desc)
      tags.sort (b, a)-> a.userCount - b.userCount
      cb null, tags

module.exports = (req, res)!->
  getTags (err, tags)!->
    if err
      res.status 500 .end!
    else
      res.render 'signup', tags
