// 下面虽然写了一大段README, 但是其实前后端代码加起来只用写20行左右

- example
    - 前端
        - html(调用UI组件)
            - jade代码
                form#the-form(enctype='multipart/form-data')
                    input#avatar-input(type='file' name='avatar')
                    image-cropper(input='#avatar-input' preview='#avatar-preview')
                        include image-cropper
                    div#avatar-preview
            - 注释
                - 效果: 当input(type='file')发生变化时, image-cropper会显示选择的图片, 同时拖动裁剪范围时, preview框会实时更新供预览
                - image-cropper是imageCropper的自定义标签, 展示出来是一个图片裁剪框, input和preview属性都是一个jquery selector, input应指向绑定的input(type='file'), preview应指向用于裁剪预览的一个div, 使用时添加image-cropper标签, 指定两个属性, 然后include image-cropper即可
                - 裁剪框image-cropper和预览框div#avatar-preview的大小可以用css指定(此外边框也是可以的), 注意预览框的长宽比会决定裁剪范围的长宽比, 也就是说, 裁剪框的长宽比可以随意设置, 但是预览框的长宽比要按需要设置, 比如要裁剪正方形头像, 预览框的长宽比应该是1:1
                - image-cropper所在的form的enctype属性应设置为'multipart/form-data'
                - 再次强调: input, cropper和preview三者没有固定的html结构, 以上只是示例, 如何排版以及部分样式可以自由发挥, 仅需在image-cropper的属性中绑定input和preview即可
        - js(提交表单)
            - ls代码
                $('#the-form').on 'submit', !->
                    $.ajax {
                        url: '/s-url'
                        type: 'POST'
                        processData: false
                        contentType: false
                        data: new FormData(@)
                        success: (data)!-> console.log data
                    }
            - 注释
                请按示例代码进行表单提交, 各种细节不多解释, 有疑问自行探索或者联系我了解
    - 后端
        - controller
            - ls代码
                require! '../../imageCropper'
                module.exports = (req, res)!->
                    uploadPath = path.join __dirname, '..', '..', 'upload', 'avatars'  // 注意使用__dirname生成绝对路径, 不能使用相对路径
                    imageCropper.save req, 'avatar', uploadPath, 'username', (dest, filename)!->
                        console.log "图片上传到#{fullPath}, 文件名为#{filename}"  // fullPath为包括文件名的绝对路径
            - 注释
                - 效果: 调用imageCropper.save后, 上传的图片将根据客户端传来的参数进行裁剪并保存到指定路径
                - 参数: imageCropper.save req, fieldName, uploadPath, filenameWithoutExtension, callback(fullPath, filename)
                - 自动保留扩展名, 所以参数中的文件名不必包含扩展名, 比如上述代码, 保存结果为username.jpg(假设上传的是jpg)
- 更详细的实例代码可以参考signup页面和controller
