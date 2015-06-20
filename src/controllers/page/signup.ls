require! {
  Tag: '../../models/tag'
}

toArray = (arrayLike)-> return [].map.call arrayLike, (item)-> item.toObject!

getTags = (cb)!->
  Tag.find {}, {meta: 0, users: 0}, (err, tags)!->
    if err
      cb err
    else
      tags = toArray(tags)
      # count activities
      tags.forEach (tag)!-> tag.actCount = tag.activities.length
      # remove activities field
      tags.forEach (tag)!-> delete tag.users
      # sort by act count(desc)
      tags.sort (b, a)-> a.actCount - b.actCount
      cb null, tags

module.exports = (req, res)!->
  getTags (err, tags)!->
    if err
      res.status 500 .end!
    else
      res.render 'signup', tags: tags
