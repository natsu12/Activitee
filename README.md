# Activitee

## 项目介绍
请看[视频介绍](http://v.youku.com/v_show/id_XMTI2NzYxNjcyOA==.html?qq-pf-to=pcqq.c2c)（第一次录制视频，制作失误导致非常不清晰，请谅解，只介绍了主要的功能，有较多功能被遗漏）。

## 服务器地址
项目已部署服务器，可以直接[访问](http://120.24.211.137:5000/)。

## 安装及运行
1. 安装NodeJs和MonogoDB（windows下请将MonogoDB根目录加入环境变量，以免无法执行导入数据的相关命令）
2. 安装ImageMagick：ubuntu下执行`sudo apt-get install imagemagick`，mac下执行`brew install imagemagick`（请先安装homebrew），windows下请参照[官网](http://www.imagemagick.org/script/binary-releases.php#windows)，选择适当版本安装。
3. 执行`mongod`（在默认的27017端口运行MonogoDB）。
4. 在项目根目录，执行`npm install`。
5. 进入`/data`目录，执行`sh import.sh`（Windows下请使用Git Bash命令行执行此命令），来导入项目数据。
6. 在项目根目录，执行`grunt watch`。

## 项目汇报
项目汇报在`doc`目录下。

## 文件目录结构
```
.
├── doc     存放项目需求、分工、项目汇报等文档
├── upload  用户上传的图片，包括avatar（头像），cover（活动封面）
├── data    存放伪造数据的json文件
└── src     项目的代码
    ├── controllers       页面后端的逻辑控制（后端主要在此目录下编写代码）
        ├── page          处理各个页面需要渲染的数据
        └── service       从前端发送来的各种请求的接口
    ├── models            存放MongoDB模型
    ├── Passport          登陆注册的模块
    ├── public            项目静态文件（图片、用户上传的图片、前端各种框架插件、样式文件less、客户端livescript）
        └── pages         存放样式文件less和客户端livescript（前端主要在此目录下编写代码）
    ├── routes            存放路由控制文件
        └── index.ls      定义了各个url应调用controller中的哪个接口
    ├── schemas           定义了项目的数据模型，注释中标明了每个模型具有的属性的含义，原则上不要改动
    └── views             存放网页前端视图模板
    
```
