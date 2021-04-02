---
title: 配置vue项目中scss的全局变量
date: 2021-01-05 16:05:00
tags: [scss, vue, webpack]
categories: [Vue相关]
---

看到了一个[教程](https://mp.weixin.qq.com/s/LKaHJX1cwLlkzU7qQ7kkwg)

![](https://7675-vuepress-7g6mefe5ad729c51-1258812673.tcb.qcloud.la/Image/2021/scss2.png?sign=44abd10cb75326db0e8b3e11ab78b70d&t=1617096391)

我们可以在 vue 项目中配置全局变量以便于引入，而不用在每一个页面 import，是不是很方便！（这里就有疑问了）我们在 main.js 全局引入不就好了吗？答案是：不生效，至于为什么我猜测有关于预处理器的原因。

**问题：**
我们希望在子页面可以全局的使用 scss 变量
![](https://7675-vuepress-7g6mefe5ad729c51-1258812673.tcb.qcloud.la/Image/2021/scss1.png?sign=29472605d1bdbca9e2f66b5a54de9fe2&t=1617096362)

按照教程的做法，修改了 vue.config.js 当中的 css 配置项，然而并不生效，并且报错“Undefined variable”。

**分析：**
“Undefined variable”
这个报错可以看出 variable.scss 肯定没有引入成功，问题出在 vue.config.js 的配置项上，通过搜索相关资料，发现有不同的版本。十分懵逼

```javascript
module.exports = {
  css: {
    loaderOptions: {
      scss: {
        prependData: `@import "@/assets/styles/_variables.scss";`,
      },
    },
  },
};
```

```javascript
module.exports = {
  css: {
    loaderOptions: {
      scss: {
        additionalData: `@import "~@/assets/styles/_variables.scss";`,
      },
    },
  },
};
```

**尝试：** 我一个个试了一遍然而都没有用……

**分支问题：**

1. sass-loader 是什么？
2. 为何配置项 loaderOptions 中有的是 scss，有的是 sass，他们之间有何区别？

**解答：**

1. sass-loader 是一种预处理器，可以将 sass 编译为 css 代码。
2. scss 是 sass 3 引入的新语法，可以理解 scss 基于 sass，所以 sass-loader 可以处理 scss

Google 一下，看到[这篇文章](https://css-tricks.com/how-to-import-a-sass-file-into-every-vue-component-in-an-app/)

![原来不同版本有不同的写法](https://7675-vuepress-7g6mefe5ad729c51-1258812673.tcb.qcloud.la/Image/2021/scss6.png?sign=5e3b0932916112a880e8297d5b59c57b&t=1617096705)

![项目中sass-loader的版本为7.0](https://7675-vuepress-7g6mefe5ad729c51-1258812673.tcb.qcloud.la/Image/2021/scss3.png?sign=c4202ced6568591ed4d5bb29279dd2fb&t=1617096402)

**解决：**
使用命令安装下预处理器

```
npm install --save-dev node-sass sass-loader
```

![安装完成后，项目中版本升级了](https://7675-vuepress-7g6mefe5ad729c51-1258812673.tcb.qcloud.la/Image/2021/scss4.png?sign=2c43f9d645fa3bfb538b748c9a643893&t=1617096415)

配置项中的参数为 data，修改 vue.config.js 配置项为：

```javascript
module.exports = {
  css: {
    loaderOptions: {
      scss: {
        data: `@import "@/assets/scss/variables.scss";`,
      },
    },
  },
};
```

**结论：**
原来是版本的问题，升级版本且对应使用配置项的 key 值

**参考链接：**

- https://stackoverflow.com/questions/53686780/setting-global-sass-variablesin-a-vue-project
- https://cli.vuejs.org/zh/guide/css.html#postcss
- https://vueschool.io/articles/vuejs-tutorials/globally-load-sass-into-your-vue-js-applications/
- https://css-tricks.com/how-to-import-a-sass-file-into-every-vue-component-in-an-app/
