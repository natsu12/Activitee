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

## 各个页面需求和分工
请阅读`/doc`目录下的`分工明细.pdf`

## 工作流程规范
1. 为保持每个人本地仓库中的代码是最新的，请在每天早上（或者编写代码之前）执行`git pull git@github.com:natsu12/Activitee.git`，（如果嫌链接太长，可以执行`git remote add zuzhang git@github.com:natsu12/Activitee.git`，那下次就可以直接`git pull zuzhang`，或者用其他你喜欢的名称代替zuzhang）
2. 如果在pull的时候发现冲突，请参考[issue](https://github.com/natsu12/Activitee/issues/4)的解决办法。
3. 建议每天晚上12点前（或者编写完代码之后）至少给我pull request一次，让我好掌握每个人的进度。
4. 所有跟项目直接相关的讨论都需要在github上进行。有相关的第三方文档资料或博客请发issue，有问题请发issue或者在commit中添加评论，方便之后对前面工作的审查。尽量不要在Q群上讨论，Q群只用来通知。
