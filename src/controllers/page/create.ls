require! {Activity:'../../models/activity', Tag:'../../models/tag', Comment:'../../models/comment'}

# create page
module.exports = (req, res)!->
	Tag.find {}, (err, tags)->
		if err
			console.log err
		tagNames = []
		for tag in tags
			tagNames.push tag.name
		res.render 'create', {
			title: '发布活动信息'
			user: req.user
			tagNames: tagNames
		}
