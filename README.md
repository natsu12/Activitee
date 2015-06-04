# Activitee

## install & start development
1. install MonogoDB
2. run mongod (on default port 27017)
3. npm install
4. grunt watch

## 文件目录结构
```
.
├── UI      存放UI设计图
├── doc     存放项目需求、分工等文档
├── upload  用户上传的图片，包括avatar（头像），images（活动图片），cover（活动封面）
└── src     项目的代码
    ├── controllers       页面后端的逻辑控制（后端主要在此目录下编写代码）
        ├── page          处理各个页面需要渲染的数据
        └── service       从前端发送来的各种请求的接口
    ├── models            存放MongoDB模型
    ├── Passport          登陆注册的模块
    ├── public            项目静态文件（图片、用户上传的图片、前端各种框架插件、样式文件less、客户端livescript）
        ├── stylesheets   样式文件less（前端主要在此目录下编写代码）
        └── pages         客户端livescript（前端主要在此目录下编写代码）
    ├── routes            存放路由控制文件
        └── index.ls      定义了各个url应调用controller中的哪个接口
    ├── schemas           定义了项目的数据模型，注释中标明了每个模型具有的属性的含义，原则上不要改动
    └── views             存放网页前端视图模板
    
```

## 工作流程规范
1. 后端主要在`/controllers`目录下编写代码，包括所有数据库的读写操作，不需要在`/schemas`中定义公有方法。
2. 按照文档，自行设计负责的页面所需要的接口，编写好一个接口后，可以改动`/routes/index.ls`，让前端请求某url时调用到该接口。
3. 为保持每个人本地仓库中的代码是最新的，请在每天早上（或者编写代码之前）执行`git pull git@github.com:natsu12/Activitee.git`，（如果嫌链接太长，可以执行`git remote add XXXX git@github.com:natsu12/Activitee.git`，那下次就可以直接`git pull XXXX master`）
4. 如果在pull的时候发现冲突，请参考[issue](https://github.com/natsu12/Activitee/issues/4)的解决办法。
5. 建议每天晚上12点前（或者编写完代码之后）至少给我pull request一次，让我好掌握每个人的进度。
6. 所有跟项目直接相关的讨论都需要在github上进行。有相关的第三方文档资料或博客请发issue，有问题请发issue或者在commit中添加评论，方便之后对前面工作的审查。尽量不要在Q群上讨论，Q群只用来通知。
