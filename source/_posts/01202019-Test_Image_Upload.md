---
title: 测试图片上传
categories:
  - Hexo
tags:
  - Hexo
  - Qshell
image: http://ploojkqh4.bkt.clouddn.com/201901291.jpg
abbrlink: 79a6148d
date: 2019-01-20 23:13:25
---
<p class="description">hexo博客图片上传方法</p>
<!-- more -->
看看玛雅人的智慧，多霸气！
<div align="center">
    <img src="http://ploojkqh4.bkt.clouddn.com/maya.jpg" width="300" alt="No Picture, No NetWork"/>
</div>

下面就放下本人的玉照，就拿他当头像了！
<div align="center">
    <img src="http://ploojkqh4.bkt.clouddn.com/me.jpg" width="300" alt="No Picture, No NetWork"/>
</div>

目前是用了hexo-asset-image插件本地上传的图片，
正在申请七牛云图床，方便图片视频管理，以后再改动下。

2019-01-21加：

终于搞好了七牛图床问题，使用管理台只能单个上传文件，比较麻烦，而使用七牛云自己的命令行工具qshell可以

在本地进行批量上传操作，非常方便。

简记如下：

1. 下载qshell包

2. 将目录添加到环境变量

   > export PATH=$PATH:/home/qshell

3. 从七牛云管理台中获取账户密钥信息，AK,SK

   > 个人中心 —> 秘钥管理

   使用命令建立账号信息

   > qshell account  AK  SK accountName

   执行后，生成~/.qshell/目录，可以查看account.json有刚输入的账户信息，

   在该目录下新建upload.conf文件，输入如下配置信息

   ```json
   {
       "src_dir": "/stuff/localImageFolder",   # 图片存放的本地目录
       "bucket": "yourBucketName"             # 你的存储空间名
   }
   ```

   建好后就可以进行批量上传图片了

   > cd ~/.qshell/        # 切换到.qshell目录来使用上传配置文件upload.conf
   >
   > qshell qupload upload.conf

   OK，上传成功，赶紧到管理台看看成功没？在图片后方点击复制外链，愉快的粘贴到md文件中吧！

   参考[qshell gitHub地址](https://github.com/qiniu/qshell)，[qshell 使用指南](https://developer.qiniu.com/kodo/kb/1685/using-qshell-synchronize-directories)
4. 2019.1.24日补：
   上传完以后可以通过`qshell listbucket bucketname`来查看仓库里的图片列表，判断是否上传成功。
   实际编写博客时，这样上传图片肯定很麻烦，我的thinkpad上装的是windows系统，用cmder来模拟linux终端操作，自带git,vim,grep,sed等命令，也是个神器，
   研究了半天它的别名alias操作，最后发现非常简单。
   ```txt
   cd /d/cmder/config    # 到cmder安装目录下
   vi user_profile.sh
   
   # 在其中加入以下别名
   alias blog='cd /e/taoblogSource'
   alias post='cd /e/taoblogSource/source/_posts'
   alias img='cd /e/imageTmp/' 
   # 需要先清缓存
   alias upimg='cd /c/Users/LYPC/.qshell && rm -rf qupload/ && qshell qupload /c/Users/LYPC/.qshell/upload.conf && echo "done"'
   alias sub='/d/SublimeText3/sublime_text.exe'
   alias ..='cd ..'
   function pull(){
     blog && git pull && echo "done"
   }
   function push(){
    blog && git add . && git commit -m "$1" && git push && echo "done"
   }
   alias pub='hexo cl && hexo d -g && echo "done"'
   alias next='cd /e/taoblogSource/themes/next'
   # local是关键字
   function loc(){
     blog && hexo cl && hexo s -g
   }
   ```
   设置好以后，windows重启cmder,mac需要执行source命令来启用别名。
   这样以后写博客可以这样
   1. post
   2. hexo n postname
      这里修改下新建post的默认模板
      ```
      blog
      cd scaffolds/
      vi post.md
      ```
   3. 写完后用`hexo s -g`查看效果
   4. push
   5. pub
5. 可以用`hexo list post`查看所有博客基本情况
6. 修改配置文件中的new_post_name来默认新的post的文件名，可以默认为月日年-名字.md
7. 提交注释有空格时用单引号括起来`push 'comment space'`

<hr />
{% fi http://ploojkqh4.bkt.clouddn.com/201901291.jpg, "", "" %}
