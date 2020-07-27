<!--trees 递归子组件-->
<qs module="handler">
var inline = {
  abbr: 1,
  b: 1,
  big: 1,
  code: 1,
  del: 1,
  em: 1,
  i: 1,
  ins: 1,
  label: 1,
  q: 1,
  small: 1,
  span: 1,
  strong: 1,
  sub: 1,
  sup: 1
}
module.exports = {
  visited: function (e, owner) {
    if (!e.instance.hasClass('_visited'))
      e.instance.addClass('_visited')
    owner.callMethod('linkpress', e)
  },
  use: function (item) {
    return !item.c && !inline[item.name] && (item.attrs.style || '').indexOf('display:inline') == -1
  }
}
</qs>
<block qq:for="{{nodes}}" qq:for-item="n" qq:for-index="i" qq:key="i">
  <!--图片-->
  <view qq:if="{{n.name=='img'}}" id="{{n.attrs.id}}" class="_img {{n.attrs.class}}" style="{{n.attrs.style}}" data-attrs="{{n.attrs}}" bindtap="imgtap">
    <rich-text nodes="{{[{attrs:{src:loading&&ctrl[i]!=2?loading:(lazyLoad&&!ctrl[i]?placeholder:n.attrs.src||''),alt:n.attrs.alt||'',width:n.attrs.width||'',style:'-webkit-touch-callout:none;max-width:100%;display:block'+(n.attrs.height?';height:'+n.attrs.height:'')},name:'img'}]}}" />
    <image class="_image" src="{{lazyLoad&&!ctrl[i]?placeholder:n.attrs.src}}" lazy-load="{{lazyLoad}}" data-i="{{i}}" data-index="{{n.attrs.i}}" data-source="img" bindload="loadImg" binderror="error" />
  </view>
  <!--文本-->
  <text qq:elif="{{n.type=='text'}}" decode>{{n.text}}</text>
  <text qq:elif="{{n.name=='br'}}">\n</text>
  <!--链接-->
  <view qq:elif="{{n.name=='a'}}" id="{{n.attrs.id}}" class="_a {{n.attrs.class}}" hover-class="_hover" style="{{n.attrs.style}}" data-attrs="{{n.attrs}}" bindtap="{{handler.visited}}">
    <trees class="_node" nodes="{{n.children}}" />
  </view>
  <!--视频-->
  <block qq:elif="{{n.name=='video'}}">
    <view qq:if="{{n.lazyLoad&&!n.attrs.autoplay}}" id="{{n.attrs.id}}" class="_video {{n.attrs.class}}" style="{{n.attrs.style}}" data-i="{{i}}" bindtap="loadVideo" />
    <video qq:else id="{{n.attrs.id}}" class="{{n.attrs.class}}" style="{{n.attrs.style}}" autoplay="{{n.attrs.autoplay}}" controls="{{n.attrs.controls}}" loop="{{n.attrs.loop}}" muted="{{n.attrs.muted}}" poster="{{n.attrs.poster}}" src="{{n.attrs.source[n.i||0]}}" unit-id="{{n.attrs['unit-id']}}" data-i="{{i}}" data-source="video" binderror="error" bindplay="play" />
  </block>
  <!--音频-->
  <audio qq:elif="{{n.name=='audio'}}" id="{{n.attrs.id}}" class="{{n.attrs.class}}" style="{{n.attrs.style}}" author="{{n.attrs.author}}" autoplay="{{n.attrs.autoplay}}" controls="{{n.attrs.controls}}" loop="{{n.attrs.loop}}" name="{{n.attrs.name}}" poster="{{n.attrs.poster}}" src="{{n.attrs.source[n.i||0]}}" data-i="{{i}}" data-source="audio" binderror="error" bindplay="play" />
  <!--广告-->
  <ad qq:elif="{{n.name=='ad'}}" class="{{n.attrs.class}}" style="{{n.attrs.style}}" unit-id="{{n.attrs['unit-id']}}" data-source="ad" binderror="error" />
  <!--列表-->
  <view qq:elif="{{n.name=='li'}}" id="{{n.attrs.id}}" class="{{n.attrs.class}}" style="{{n.attrs.style}};display:flex">
    <view qq:if="{{n.type=='ol'}}" class="_ol-bef">{{n.num}}</view>
    <view qq:else class="_ul-bef">
      <view qq:if="{{n.floor%3==0}}" class="_ul-p1">█</view>
      <view qq:elif="{{n.floor%3==2}}" class="_ul-p2" />
      <view qq:else class="_ul-p1" style="border-radius:50%">█</view>
    </view>
    <trees class="_node _li" lazy-load="{{lazyLoad}}" loading="{{loading}}" nodes="{{n.children}}" />
  </view>
  <!--富文本-->
  <rich-text qq:elif="{{handler.use(n)}}" id="{{n.attrs.id}}" class="_p __{{n.name}}" nodes="{{[n]}}" />
  <!--继续递归-->
  <trees qq:else id="{{n.attrs.id}}" class="_node _{{n.name}} {{n.attrs.class}}" style="{{n.attrs.style}}" lazy-load="{{lazyLoad}}" loading="{{loading}}" nodes="{{n.children}}" />
</block>