require! {gm, path}

gm = gm.subClass imageMagick: true

crop = (src, dest, cropX, cropY, cropWidth, cropHeight, cb)!->
  gm src
  .crop cropWidth, cropHeight, cropX, cropY
  .write dest, cb

save = (req, fieldname, path_, name, cb)!->
  cropX = req.body["image-cropper-#{fieldname}-crop-x"]
  cropY = req.body["image-cropper-#{fieldname}-crop-y"]
  cropWidth = req.body["image-cropper-#{fieldname}-crop-width"]
  cropHeight = req.body["image-cropper-#{fieldname}-crop-height"]
  file = req.files[fieldname]
  filename = name + '.' + file.extension
  dest = path.join(path_, filename)
  crop req.files[fieldname].path, dest, cropX, cropY, cropWidth, cropHeight, (err)!->
    if err
      console.log err
    else
      cb dest, filename

module.exports = save: save
