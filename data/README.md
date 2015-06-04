使用方法
- 对password做hash(必需! 生成user\_.json): node hash.js
- 导入数据(导入activities, users\_, tags): sh import
- 如果出现`insertDocument :: caused by :: 11000 E11000 duplicate key error index`报错，说明你之前导入过旧数据，请用mongo命令行运行`use activitee`和`db.dropDatabase()`
