// 下面虽然写了一大段README, 但是其实前后端代码加起来只用写20行左右

- example
    - 前端
        - html(调用UI组件)
            - jade代码
                form#the-form(enctype='multipart/form-data')
                    // other fields
                    input#avatar-input(type='file' name='avatar')
                    image-cropper(input='#avatar-input' preview='#avatar-preview')
                        include image-cropper
                    div#avatar-preview
                    // other fields
            - 注释
                - image-cropper是imageCropper的自定义标签, input和preview属性都是一个jquery selector, 分别指向一个input('type'='file')和一个div
                - 效果: 当input发生变化时(选择一张图片), image-cropper会显示选择的图片, 同时拖动裁剪范围时, preview会实时更新供预览, 提交表单时会自动附加裁剪参数
                - image-cropper和preview的大小可以用css指定(此外边框也是可以的), 注意preview的长宽比会决定裁剪范围的长宽比, 比如要裁剪正方形头像, 应该把preview的长宽比设为1:1, image-cropper的大小可以随意指定, 显示的图片会缩放适应
                - image-cropper所在的form的enctype属性应设置为'multipart/form-data'
                - 再次强调: input, cropper和preview三者没有固定的顺序, 以上只是示例, 如何排版以及部分样式可以自由发挥, 仅需在image-cropper的属性中绑定input和preview即可
        - js(提交表单)
            - ls代码
                # other codes...
                $('#the-form').on 'submit', (e)!->  # 监听表单提交事件
                    e.preventDefault!  # 阻止默认提交动作
                    $.ajax {  # ajax提交
                        url: '/s-url'
                        type: 'POST'
                        processData: false  # 必须
                        contentType: false  # 必须
                        data: new FormData(@)  # 必须用FormData进行encode
                        success: (data)!-> 'do something with data'  # callback
                    }
                # other codes...
            - 注释
                请严格按示例代码进行表单提交, 理论上还有一些自由空间, 不过没什么必要, 有兴趣自行探索
    - 后端
        - controller
            - ls代码
                require! '../../imageCropper'
                module.exports = (req, res)!->
                    # other codes...
                    uploadPath = path.join __dirname, '..', '..', 'upload', 'avatars'  // 注意使用__dirname生成绝对路径, 不能使用相对路径
                    imageCropper.save req, 'avatar', uploadPath, 'username', (dest, filename)!->
                        console.log "图片上传到#{fullPath}, 文件名为#{filename}"  // fullPath为包括文件名的绝对路径
                        # other codes...
            - 注释
                - 效果: 调用imageCropper.save后, 上传的图片将根据客户端传来的参数进行裁剪并保存到指定路径
                - 参数: imageCropper.save req, fieldName, uploadPath, filenameWithoutExtension, callback(fullPath, filename)
                - 参数中的fieldname就是前端input(type='file')的name属性
                - 自动保留扩展名, 所以参数中的文件名不必包含扩展名, 比如上述代码, 保存结果为username.jpg(假设上传的是jpg)
- 更详细的实例代码可以参考signup页面和controller
