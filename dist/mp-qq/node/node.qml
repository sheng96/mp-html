<qs module="isInline">var e={abbr:!0,b:!0,big:!0,code:!0,del:!0,em:!0,i:!0,ins:!0,label:!0,q:!0,small:!0,span:!0,strong:!0,sub:!0,sup:!0};module.exports=function(n,i){return e[n]||-1!==(i||"").indexOf("inline")};</qs><template name="el"><block qq:if="{{n.name==='img'}}"><rich-text qq:if="{{n.t}}" style="display:{{n.t}}" nodes="<img class='_img' style='{{n.attrs.style}}' src='{{n.attrs.src}}'>" data-i="{{i}}" catchtap="imgTap"/><block qq:else><image qq:if="{{(opts[1]&&!ctrl[i])||ctrl[i]<0}}" class="_img" style="{{n.attrs.style}}" src="{{ctrl[i]<0?opts[2]:opts[1]}}" mode="widthFix"/><image id="{{n.attrs.id||('n'+i)}}" class="_img {{n.attrs.class}}" style="{{ctrl['e'+i]?'border:1px dashed black;padding:3px;':''}}{{ctrl[i]===-1?'display:none;':''}}width:{{ctrl[i]||1}}px;height:{{ctrl['h'+i]||1}}px;{{n.attrs.style}}" src="{{n.attrs.src}}" mode="{{!n.h?'widthFix':(!n.w?'heightFix':(n.m||'scaleToFill'))}}" lazy-load="{{opts[0]}}" data-i="{{i}}" bindload="imgLoad" binderror="mediaError" catchtap="imgTap" bindlongpress="noop"/></block></block><block qq:elif="{{n.type==='text'}}"><text qq:if="{{!ctrl['e'+i]}}" data-i="{{i}}" decode="{{!opts[5]}}" bindtap="editStart">{{n.text}}<text qq:if="{{!n.text}}" style="color:gray">{{opts[6]||'请输入'}}</text></text><text qq:elif="{{ctrl['e'+i]===1}}" data-i="{{i}}" style="border:1px dashed black;min-width:50px;width:auto;padding:5px;display:block" catchtap="editStart">{{n.text}}<text qq:if="{{!n.text}}" style="color:gray">{{opts[6]||'请输入'}}</text></text><textarea qq:else style="border:1px dashed black;min-width:50px;width:auto;padding:5px" auto-height maxlength="-1" focus="{{ctrl['e'+i]===3}}" value="{{n.text}}" data-i="{{i}}" bindinput="editInput" bindblur="editEnd"/></block><text qq:elif="{{n.name==='br'}}">\n</text><view qq:elif="{{n.name==='a'}}" id="{{n.attrs.id}}" class="{{n.attrs.href?'_a ':''}}{{n.attrs.class}}" hover-class="_hover" style="display:inline;{{n.attrs.style}}" data-i="{{i}}" catchtap="linkTap"><node childs="{{n.children}}" opts="{{[opts[0],opts[1],opts[2],opts[3],opts[4],opts[5],opts[6],opts[7]+i+'_']}}" style="display:inherit"/></view><video bindtap="mediaTap" qq:elif="{{n.name==='video'}}" id="{{n.attrs.id}}" class="{{n.attrs.class}}" style="{{n.attrs.style}}" autoplay="{{n.attrs.autoplay}}" controls="{{n.attrs.controls}}" loop="{{n.attrs.loop}}" muted="{{n.attrs.muted}}" object-fit="{{n.attrs['object-fit']}}" poster="{{n.attrs.poster}}" src="{{n.src[ctrl[i]||0]}}" data-i="{{i}}" bindplay="play" binderror="mediaError"/><audio bindtap="mediaTap" qq:elif="{{n.name==='audio'}}" id="{{n.attrs.id}}" class="{{n.attrs.class}}" style="{{n.attrs.style}}" author="{{n.attrs.author}}" controls="{{n.attrs.controls}}" loop="{{n.attrs.loop}}" name="{{n.attrs.name}}" poster="{{n.attrs.poster}}" src="{{n.src[ctrl[i]||0]}}" data-i="{{i}}" bindplay="play" binderror="mediaError"/><rich-text qq:else id="{{n.attrs.id}}" style="{{n.f}}" nodes="{{[n]}}"/></template><block qq:for="{{childs}}" qq:for-item="n1" qq:for-index="i1" qq:key="i1"><template qq:if="{{(opts[5]?true:!n1.c)&&(!n1.children||n1.name==='a'||!(opts[5]?true:isInline(n1.name,n1.attrs.style)))}}" is="el" data="{{n:n1,i:''+i1,opts:opts,ctrl:ctrl}}"/><view qq:else data-i="{{''+i1}}" bindtap="nodeTap" id="{{n1.attrs.id}}" class="_{{n1.name}} {{n1.attrs.class}}" style="{{ctrl['e'+i1]?'border:1px solid black;padding:5px;display:block;':''}}{{n1.attrs.style}}"><block qq:for="{{n1.children}}" qq:for-item="n2" qq:for-index="i2" qq:key="i2"><template qq:if="{{(opts[5]?true:!n2.c)&&(!n2.children||n2.name==='a'||!(opts[5]?true:isInline(n2.name,n2.attrs.style)))}}" is="el" data="{{n:n2,i:i1+'_'+i2,opts:opts,ctrl:ctrl}}"/><view qq:else data-i="{{i1+'_'+i2}}" bindtap="nodeTap" id="{{n2.attrs.id}}" class="_{{n2.name}} {{n2.attrs.class}}" style="{{ctrl['e'+i1+'_'+i2]?'border:1px solid black;padding:5px;display:block;':''}}{{n2.attrs.style}}"><block qq:for="{{n2.children}}" qq:for-item="n3" qq:for-index="i3" qq:key="i3"><template qq:if="{{(opts[5]?true:!n3.c)&&(!n3.children||n3.name==='a'||!(opts[5]?true:isInline(n3.name,n3.attrs.style)))}}" is="el" data="{{n:n3,i:i1+'_'+i2+'_'+i3,opts:opts,ctrl:ctrl}}"/><view qq:else data-i="{{i1+'_'+i2+'_'+i3}}" bindtap="nodeTap" id="{{n3.attrs.id}}" class="_{{n3.name}} {{n3.attrs.class}}" style="{{ctrl['e'+i1+'_'+i2+'_'+i3]?'border:1px solid black;padding:5px;display:block;':''}}{{n3.attrs.style}}"><block qq:for="{{n3.children}}" qq:for-item="n4" qq:for-index="i4" qq:key="i4"><template qq:if="{{(opts[5]?true:!n4.c)&&(!n4.children||n4.name==='a'||!(opts[5]?true:isInline(n4.name,n4.attrs.style)))}}" is="el" data="{{n:n4,i:i1+'_'+i2+'_'+i3+'_'+i4,opts:opts,ctrl:ctrl}}"/><view qq:else data-i="{{i1+'_'+i2+'_'+i3+'_'+i4}}" bindtap="nodeTap" id="{{n4.attrs.id}}" class="_{{n4.name}} {{n4.attrs.class}}" style="{{ctrl['e'+i1+'_'+i2+'_'+i3+'_'+i4]?'border:1px solid black;padding:5px;display:block;':''}}{{n4.attrs.style}}"><block qq:for="{{n4.children}}" qq:for-item="n5" qq:for-index="i5" qq:key="i5"><template qq:if="{{(opts[5]?true:!n5.c)&&(!n5.children||n5.name==='a'||!(opts[5]?true:isInline(n5.name,n5.attrs.style)))}}" is="el" data="{{n:n5,i:i1+'_'+i2+'_'+i3+'_'+i4+'_'+i5,opts:opts,ctrl:ctrl}}"/><node qq:else id="{{n5.attrs.id}}" class="_{{n5.name}} {{n5.attrs.class}}" style="{{n5.attrs.style}}" childs="{{n5.children}}" opts="{{[opts[0],opts[1],opts[2],opts[3],opts[4],opts[5],opts[6],opts[7]+i1+'_'+i2+'_'+i3+'_'+i4+'_'+i5+'_']}}"/></block></view></block></view></block></view></block></view></block>