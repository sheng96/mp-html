/**
 * @fileoverview 递归子组件，用于显示节点树
 */
Component({
  data: {
    ctrl: {} // 控制信号
  },
  properties: {
    childs: Array,  // 子节点列表
    opts: Array     // 设置 [是否开启懒加载, 加载中占位图, 错误占位图, 是否使用长按菜单]
  },
  // #ifdef MP-BAIDU || MP-ALIPAY
  created() {
    // #ifdef MP-BAIDU
    this.dispatch('add')
    // #endif
    // #ifdef MP-ALIPAY
    this.props.onAdd(this)
    // #endif
  },
  // #endif
  methods: {
    noop() { },
    /**
     * @description 获取标签
     * @param {String} path 路径
     */
    getNode(path) {
      var nums = path.split('_'),
        node = this.properties.childs[nums[0]]
      for (var i = 1; i < nums.length; i++)
        node = node.children[nums[i]]
      return node
    },
    /**
     * @description 播放视频事件
     * @param {Event} e 
     */
    play(e) {
      if (this.root.properties.pauseVideo) {
        var flag = false, id = e.target.id
        for (var i = this.root._videos.length; i--;) {
          if (this.root._videos[i].id == id)
            flag = true
          else
            this.root._videos[i].pause() // 自动暂停其他视频
        }
        // 将自己加入列表
        if (!flag) {
          var ctx = wx.createVideoContext(id
            // #ifndef MP-BAIDU
            , this
            // #endif
          )
          ctx.id = id
          this.root._videos.push(ctx)
        }
      }
    },

    /**
     * @description 图片点击事件
     * @param {Event} e 
     */
    imgTap(e) {
      var node = this.getNode(e.target.dataset.i)
      if (node.attrs.ignore)
        return
      this.root.triggerEvent('imgtap', node.attrs)
      if (this.root.properties.previewImg) {
        var current =
          // #ifndef MP-ALIPAY
          this.root.imgList[node.i]
        // #endif
        // #ifdef MP-ALIPAY
        node.i
        // #endif
        // 自动预览图片
        wx.previewImage({
          current,
          urls: this.root.imgList
        })
      }
    },

    /**
     * @description 图片加载完成事件
     * @param {Event} e 
     */
    imgLoad(e) {
      var i = e.target.dataset.i,
        node = this.getNode(i), val
      if (!node.w)
        val = e.detail.width
      // 加载完毕，取消加载中占位图
      else if ((this.properties.opts[1] && !this.data.ctrl[i]) || this.data.ctrl[i] == -1)
        val = 1
      if (val)
        this.setData({
          ['ctrl.' + i]: val
        })
    },

    /**
     * @description 链接点击事件
     * @param {Event} e 
     */
    linkTap(e) {
      var node = this.getNode(e.currentTarget.dataset.i),
        href = node.attrs.href
      this.root.triggerEvent('linktap', node.attrs)
      if (href) {
        // 跳转锚点
        if (href[0] == '#')
          this.root.navigateTo(href.substring(1)).catch(() => { })
        // 复制外部链接
        else if (href.includes('://')) {
          if (this.root.properties.copyLink)
            wx.setClipboardData({
              data: href,
              success: () =>
                wx.showToast({
                  title: '链接已复制'
                })
            })
        }
        // 跳转页面
        else
          wx.navigateTo({
            url: href,
            fail() {
              wx.switchTab({
                url: href,
                fail() { }
              })
            }
          })
      }
    },

    /**
     * @description 错误事件
     * @param {Event} e 
     */
    mediaError(e) {
      var i = e.target.dataset.i,
        node = this.getNode(i)
      // 加载其他源
      if (node.name == 'video' || node.name == 'audio') {
        var index = (this.data.ctrl[i] || 0) + 1
        if (index > node.src.length)
          index = 0
        if (index < node.src.length)
          return this.setData({
            ['ctrl.' + i]: index
          })
      }
      // 显示错误占位图
      else if (node.name == 'img' && this.properties.opts[2])
        this.setData({
          ['ctrl.' + i]: -1
        })
      if (this.root)
        this.root.triggerEvent('error', {
          source: node.name,
          attrs: node.attrs,
          errMsg: e.detail.errMsg
        })
    },
    // #ifdef MP-ALIPAY
    add(e) {
      this.triggerEvent('add', e)
    }
    // #endif
  }
})
