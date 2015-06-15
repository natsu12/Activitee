require! {gm, path}

gm = gm.subClass imageMagick: true

crop = (src, dest, cropX, cropY, cropWidth, cropHeight, cb)!->
  gm src
  .crop cropWidth, cropHeight, cropX, cropY
  .write dest, cb

save = (req, fieldname, uploadAbsoluteDir, relativeDir, name, cb)!->
  cropX = req.body["image-cropper-#{fieldname}-crop-x"]
  cropY = req.body["image-cropper-#{fieldname}-crop-y"]
  cropWidth = req.body["image-cropper-#{fieldname}-crop-width"]
  cropHeight = req.body["image-cropper-#{fieldname}-crop-height"]
  file = req.files[fieldname]
  filename = name + '.' + file.extension
  relativePath = path.join(relativeDir, filename)
  dest = path.join(uploadAbsoluteDir, relativePath)
  crop req.files[fieldname].path, dest, cropX, cropY, cropWidth, cropHeight, (err)!->
    if err
      console.log err
    else
      cb relativePath, filename

module.exports = save: save
