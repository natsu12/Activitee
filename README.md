# Activitee

## install & start development
1. install MonogoDB
2. run mongod (on default port 27017)
3. npm install
4. grunt watch

## 数据模型
数据模式定义在`/schemas`目录下，数据模型定义在`/models`目录下

1. activity
2. user
3. tag
4. comment

关于每个模型具有的属性的含义，请参考`/schemas`目录中各个模式中的注释。注：meta属性包含的是字段的创建时间和更新时间。

## 各个页面
各页面视图定义在`/views`目录下，各路由定义在`/routes/index.ls`中

1. 首页：index （暂时不用做）
2. 活动主页：home
  * 用到的数据：
  ```
    {
      user: {
        username,
        avatar
      },
      activities: {
        id,
        title,
        cover,
        time,
        host
      },
      past_activities: {
        id,
        title,
        cover,
        time,
        host
      },
      tags: {
        name
      }
    }
  ```
  * 需求：
    1. 每个活动呈现的信息：标题，封面，活动时间，发布人
    2. 用户呈现的信息：头像，用户名
    3. 默认根据活动时间排序（暂时不弄评分）
    4. 未登录时默认呈现所有活动，登陆后呈现用户订阅的tag下的所有活动
    5. 点击tag进行筛选
    6. 分页查看
    7. 两个tab，一个tab显示未过期活动，一个tab显示过期活动
    8. 点击活动后，跳转到`/detail/:id`，进入相应的活动详情页
3. 活动详情页：detail
  * 用到的数据：
  ```
    {
      user: {
        username,
        avatar
      },
      activities: {
        id,
        title,
        summary,
        time,
        place,
        host,
        people_num,
        tags,
        images,
      },
      comment: {
        avatar,
        username,
        content,
        createAt,
        reply: {
          from,
          to,
          content
        }
      }
    }
  ```
  * 需求
    1. 需要呈现活动的：标题，简介，活动时间，活动地点，发布人，活动人数，标记的tag，图片
    2. 需要呈现属于这个活动的所有评论
    3. 登陆用户可以发表评论，可以回复他人评论，叠楼式那种（一个框一个框嵌套）
    4. 登陆用户可以关注该活动，参与该活动
4. 发布活动信息：create （登陆后才可以进入）
  * 用到的数据：
  ```
    {
      user: {
        username,
        avatar
      }
    }
  ```
5. 我关注的活动：following （登陆后才可以进入）
  * 用到的数据：
  ```
    {
      user: {
        username,
        avatar
      },
      activities: {
        id,
        title,
        cover,
        time,
        host
      },
    }
  ```
6. 我参与的活动：joining （登陆后才可以进入）
  * 用到的数据：
  ```
    {
      user: {
        username,
        avatar
      },
      activities: {
        id,
        title,
        cover,
        time,
        host
      },
    }
  ```
7. 我发布的活动：host （登陆后才可以进入）
  ```
    {
      user: {
        username,
        avatar
      },
      activities: {
        id,
        title,
        cover,
        time,
        host,
        status
      },
    }
  ```
8. 修改活动信息：edit （登陆后才可以进入）
* 用到的数据：
  ```
    {
      user: {
        username,
        avatar
      },
      activities: {
        id,
        title,
        summary,
        time,
        place,
        host,
        people_num,
        tags,
        images,
      }
    }
  ```
9. 活动审核页：admin （管理员才可以进入）
  * 用到的数据：
  ```
    {
      user: {
        username,
        avatar
      },
      activities: {  //status为0
        id,
        title,
        cover,
        time,
        host
      },
    }
  ```
10. 登录页：signin
11. 注册页：register
