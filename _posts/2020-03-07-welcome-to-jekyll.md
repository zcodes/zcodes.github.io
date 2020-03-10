---
layout: post
title:  "博客搭建"
date:   2020-03-07 17:13:24 +0800
categories: jekyll update
---

博客已经不再“流行”，写博客也沦为了“古董级”的行为。

这个博客基本上建了拆，拆了建，有很多次了。究其原因，可能是我自己都不知道自己为
什么要弄一个博客，也不知道自己为什么不弄一个博客。时间久了，年纪大了，“折腾”的
心也没了什么“激情”，所以，也许，可能，很长时间，这个博客会一直是这个样子下去了。

## Jekyll + Github Pages

在启动一个博客前，有两点需要仔细考量:

1. 如何管理博客内容？
2. 在什么地方托管博客？

搭建一个博客也有很多种方式，比如:

* 选择 BSP（Blog Service Provider）
* 选择 WordPress 等针对博客的 CMS
* 选择 Jekyll, Hexo, Hugo 等静态网站生成器

我之所以选择 [Github Pages][github-pages-docs] + [Jekyll][jekyll-docs] 的组合，
基于以下考虑：

* 排除任何的 BSP。博客不再流行，BSP 缺少了利益，博客平台能否持续且稳定的存在是一
  个问题。
* 暂时不做自己搭建服务器的考虑。目前博客的状态对不起服务器费。
* 放弃 WordPress。我更喜欢用 Vim 之类的编辑器码字。
* 不选择 Hexo 或是 Hugo 等跟 Jekyll 类似的工具，是因为 Github 跟 Jekyll 更搭配，
  毕竟原生支持。

## 搭建博客

接下来记一下博客搭建的流水账吧，鉴于 Github Pages 和 Jekyll 的文档挺全，以及网上
相关内容挺多的，所以步骤并不做详解。

### Windows 下搭建 Ruby 环境

Ruby 是基于 posix 系统开发的，在 Windows 平台上混的不咋样。虽然有些不堪，但还是
可以在 Windows 上搭建一个可用 Ruby 环境。为了省去不必要的麻烦，在 Windows 上我们
直接使用编译好的 [RubyInstaller][ruby-installer]。

从 Ruby-2.4 开始，RubyInstaller 依赖 [MSYS2][msys2]，如果系统已经有 msys2，可以
选择下载 Ruby Without Devkit 版本，没有 msys2， 直接下载 Ruby+Devkit 版本。
exe 文件双击运行，不需要过多解释。

因为我的系统中已经在 C 盘安装了 msys2（目录位置 `c:\msys64`），这里以 7z 版本的
RubyInstaller (rubyinstaller-2.7.0-1-x64.7z) 为例记录一下步骤。

1. 将压缩文件解压到 `c:\Tools\Ruby26` 目录下。
2. 打开 cmd.exe，设置环境变量: `@set PATH=c:\Tools\Ruby26\bin;%PATH%`
3. 检出 Ruby 是否可运行: `ruby --version`
4. 安装和更新 `ridk`：`ridk install 1 2 3`

到这里，一个可用的 Ruby 运行环境就搭好了，接下来，我们需要做的是安装博客需要的
gem 包。

1. 安装 bundler: `gem install bundler`
2. 安装 github-pages: `gem install github-pages`

Ok, 一切准备妥当，接下里就是创建博客了。

### Linux 下搭建 Ruby 环境

Linux 下搭建 Ruby 环境就简单多了，方式也有很多。最简单的使用系统自带的 ruby，不
过可能有些系统的 ruby 版本有些低，也可以自己下载 ruby 的代码自己编译，这样有些麻
烦 。这里推荐的方式使用 [RVM][rvm]。

1. 导入 rvm 的密钥: `gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
2. 安装 rvm: `curl -sSL https://get.rvm.io | bash -s stable`
3. 安装 ruby: `rvm install 2.6.3`
4. 为博客单独创建一个 gemset: `rvm gemset create blog`
5. 切换 ruby 环境: `rvm use 2.6.3@blog`
6. 安装 bundler: `gem install bundler`
7. 安装 github-pages: `gem install github-pages`

### 创建博客

博客的创建简单的很，步骤如下:

1. 建立一个博客目录: `mkdir d:\tmp\blog` (windows) 或者 `mkdir ~/tmp/blog`
   (linux)
2. 创建博客: `jekyll new .`
3. 修改 Gemfile，注释掉 `gem "jekyll", "~> 3.8.6"`，并且取消 `gem
   "github-pages", group: :jekyll_plugins` 的注释
4. 更新一下 Gemfile.lock：`bundle update`
5. 启动博客: `jekyll serve` 或者 `bundle exec jekyll serve`
6. 打开浏览器，输入 `http://localhost:4000`

一个自带默认主题的博客创建完成。

下面一个修改后的 Gemfile 样例:
```ruby
source "https://rubygems.org"

# Hello! This is where you manage which Jekyll version is used to run.
# When you want to use a different version, change it below, save the
# file and run `bundle install`. Run Jekyll with `bundle exec`, like so:
#
#     bundle exec jekyll serve
#
# This will help ensure the proper Jekyll version is running.
# Happy Jekylling!
# gem "jekyll", "~> 3.8.5"

# This is the default theme for new Jekyll sites. You may change this to anything you like.
gem "minima", "~> 2.0"

# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
gem "github-pages", group: :jekyll_plugins

# If you have any plugins, put them here!
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.6"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.0" if Gem.win_platform?
```

### 上传到 Github

这个首要问题是有一个 Github 的账号了，然后需要新建一个以自己用户名 +
`.github.io` 的项目，比如 `zcodes.github.io`，然后将代码推送的该项目。

1. 切换到博客目录并初始化 Git 项目: `git init`
2. 添加项目内容: `git add .`
3. 提交添加内容: `git commit -m 'hello, world'`
4. 设置远程仓库路径: <br>
   `git remote add origin https://github.com/zcodes/zcodes.github.io`
5. 推送到 Github: `git push -u origin master`

接下来打开网址: `http://<username>.github.io` 就可以看到博客了。

### 给博客设置域名

Github Pages 支持自定义域名，域名设置步骤如下:

首先, 在域名商后台解析自己的域名，添加 A 记录指向下了 ip 地址:

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

第二部是添加域名，一种方式是手动添加，即在自己博客项目下创建一个 `CNAME` 的文件
，文件内容为域名。

另一种方式，是在项目的 Github 主页，点击 Settings 选项，在 Github Pages 设置下，
填入要 绑定的域名。

![设置域名](/assets/img/gh_pages_custom_domains.png)

## 使用博客

搭建博客容易，写博客难。这暂且不表，先废话一下 Jekyll 的使用。

Jekyll 是一个静态网站生成工具，原理就是给它一坨文件，包括但不限于 css、js、
markdown 等文件，它把他们经过一系列转换（比如将 markdown 文件转换成 html 文件，
根据现有的文章生成文章列表），生成一个静态的网站（运行过 `jekyll serve` 后，
`_site` 目录目录下就是生成的网站）。

### 目录结构

Jekyll 遵循 `约定优于配置` 的原则，在固定的目录下放置固定的内容，会省去很多麻烦。
一个新建的博客目录结构如下所示:

```
.
├── _config.yml
├── _posts
│   └── 2020-03-09-welcome-to-jekyll.markdown
├── _site
│   ├── 404.html
│   ├── about
│   │   └── index.html
│   ├── assets
│   │   ├── main.css
│   │   └── minima-social-icons.svg
│   ├── feed.xml
│   ├── index.html
│   └── jekyll
│       └── update
│           └── 2020
│               └── 03
│                   └── 09
│                       └── welcome-to-jekyll.html
├── 404.html
├── about.md
├── Gemfile
├── Gemfile.lock
└── index.md
```

首先，忽略一下 `_site` 目录，git 提交的时候不需要把 `_site` 提交到 Github，它是
Jekyll 根据博客内容生成的静态网站，博客提交到 github 后，github 会自动生成
`_site`的 内容。

`_config.yml` 文件是博客的配置文件，Jekyll 在生成静态网站的时候会依赖配置的内容
，比如博客的标题。

`_post` 目录中存放的是博客的文章，而 `index.md` 和 `about.md` 是独立页面。虽然都
是 markdown 文件，生成文章还是独立页面根据的是文件开始的的 yml 属性信息，下面是
一个样例。

```yml
---
layout: post
title:  "Welcome to Jekyll!"
date:   2020-03-09 15:31:45 +0800
categories: jekyll update
---
```

`layout` 表示这是一篇文章，`title` 后面是文章的标题。

`404.html` 是网站 404 错误时的重定向页，这个页面也表示，Jekyll 不仅可以通过
markdown 生成 html 页面，也可以直接添加 html 页面。

`Gemfile` 和 `Gemfile.lock` 则是博客作为一个 ruby 项目，运行所需的 Gem 依赖管理
文件 。

以上，就是 Jekyll 默认生成新博客的目录结构，然后需要注意一下内容：

1. 以 `_` 或是 `.` 开头的目录或文件是不可以通过 Jekyll 访问的，如 `_post` 目录。
2. 没有 `_` 或是 `.` 开头的目录或文件可以直接访问，比如建一个 `assets` 文件存放
   图片或是样式文件，以及直接在建一个 `hello.html` 文件，则可以用如下方式访问:
   `http://<url>/assets/hello.png` 或是 `http://<url>/hello.html`
3. 目录结构不止局限于此，如果需要修改或是扩展主题，会用到 `_layout`、`_includes`
   、`_sass` 等目录，具体可以看一下 [jekyll 文档][jekyll-docs] 和
   [minima][minima] 主题的文档。

### 配置博客

博客配置在 `_config.yml`中，下面的示例只简单解释一下。

```yml
# Site settings
# These are used to personalize your new site. If you look in the HTML files,
# you will see them accessed via {{ site.title }}, {{ site.email }}, and so on.
# You can create any custom variable you would like, and they will be accessible
# in the templates via {{ site.myvariable }}.
title: Your awesome title # 这里配置网站的标题
email: your-email@example.com # 配置用户的邮箱
description: >- # this means to ignore newlines until "baseurl:"
  Write an awesome description for your new site here. You can edit this
  line in _config.yml. It will appear in your document head meta (for
  Google search results) and in your feed.xml site description.
# 上面几行添加的是对网站的描述
baseurl: "" # the subpath of your site, e.g. /blog
url: "" # the base hostname & protocol for your site, e.g. http://example.com
twitter_username: jekyllrb
github_username:  jekyll
```

配置只是一个 yml，有默认配置，这些配置可以影响 Jekyll 或是主题的行为，也可以 添
加自定义配置内容，可以在自定义主题（模板）的时候使用。

### 写文章

文章默认都在 `_posts` 目录下，文件命名规则为 `year-month-day-title.md`。文件头部
需要添加 yml 属性信息，之后，是 markdown 格式的文章内容。可以在本地使用 `jekyll
serve` 预览文章，git 提交并且推送的 github 后，在线的博客内容会自动更新。

## 资料列表

* [Github Pages 文档][github-pages-docs]
* [Jekyll 文档][jekyll-docs]
* [jekyll 中文文档][jekyll-docs-cn]
* [Markdown 文档](https://www.appinn.com/markdown/)
* [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
* [minima 主题][minima]

[github-pages-docs]: https://help.github.com/en/github/working-with-github-pages
[jekyll-docs]: https://jekyllrb.com/docs/
[jekyll-docs-cn]: http://jekyllcn.com/docs/home/
[ruby-installer]: https://rubyinstaller.org/downloads/
[msys2]: https://www.msys2.org/
[rvm]: https://rvm.io
[minima]: https://github.com/jekyll/minima
