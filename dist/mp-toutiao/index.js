"use strict";function t(e){"@babel/helpers - typeof";return(t="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(t){return typeof t}:function(t){return t&&"function"==typeof Symbol&&t.constructor===Symbol&&t!==Symbol.prototype?"symbol":typeof t})(e)}function e(t,e,i){return e=n(e),e in t?Object.defineProperty(t,e,{value:i,enumerable:!0,configurable:!0,writable:!0}):t[e]=i,t}function n(e){var n=i(e,"string");return"symbol"==t(n)?n:String(n)}function i(e,n){if("object"!=t(e)||!e)return e;var i=e[Symbol.toPrimitive];if(void 0!==i){var o=i.call(e,n||"default");if("object"!=t(o))return o;throw new TypeError("@@toPrimitive must return a primitive value.")}return("string"===n?String:Number)(e)}/*!
 * mp-html v2.4.3
 * https://github.com/jin-yufeng/mp-html
 *
 * Released under the MIT license
 * Author: Jin Yufeng
 */
var o=require("./parser"),r=[require("./editable/index.js")];Component({data:{nodes:[]},properties:{editable:{type:Boolean,observer:function(t){var e=this;this.data.content?this.setContent(t?this.data.content:this.getContent()):t&&(this.setData({nodes:[{name:"p",attrs:{},children:[{type:"text",text:""}]}]}),this.selectComponent("#_root",function(t){t.root=e})),t||this._maskTap()}},placeholder:String,containerStyle:String,content:{type:String,value:"",observer:function(t){this.setContent(t)}},copyLink:{type:Boolean,value:!0},domain:String,errorImg:String,lazyLoad:Boolean,loadingImg:String,pauseVideo:{type:Boolean,value:!0},previewImg:{type:Boolean,value:!0},scrollTable:Boolean,selectable:null,setTitle:{type:Boolean,value:!0},showImgMenu:{type:Boolean,value:!0},tagStyle:Object,useAnchor:null},created:function(){this.plugins=[];for(var t=r.length;t--;)this.plugins.push(new r[t](this))},detached:function(){this._hook("onDetached")},methods:{_containTap:function(){this._lock||this.data.slider||this.data.color||(this._edit=void 0,this._maskTap())},_tooltipTap:function(t){this._tooltipcb(t.currentTarget.dataset.i),this.setData({tooltip:null})},_sliderChanging:function(t){this._slideringcb(t.detail.value)},_sliderChange:function(t){this._slidercb(t.detail.value)},_colorTap:function(t){this._colorcb(t.currentTarget.dataset.i),this.setData({color:null})},in:function(t,e,n){t&&e&&n&&(this._in={page:t,selector:e,scrollTop:n})},navigateTo:function(t,n){var i=this;return new Promise(function(o,r){if(!i.data.useAnchor)return void r(Error("Anchor is disabled"));var a=tt.createSelectorQuery().in(i._in?i._in.page:i).select((i._in?i._in.selector:"._root")+(t?"".concat(">>>","#").concat(t):"")).boundingClientRect();i._in?a.select(i._in.selector).scrollOffset().select(i._in.selector).boundingClientRect():a.selectViewport().scrollOffset(),a.exec(function(t){if(!t[0])return void r(Error("Label not found"));var a=t[1].scrollTop+t[0].top-(t[2]?t[2].top:0)+(n||parseInt(i.data.useAnchor)||0);i._in?i._in.page.setData(e({},i._in.scrollTop,a)):tt.pageScrollTo({scrollTop:a,duration:300}),o()})})},getText:function(t){var e="";return function t(n){for(var i=0;i<n.length;i++){var o=n[i];if("text"===o.type)e+=o.text.replace(/&amp;/g,"&");else if("br"===o.name)e+="\n";else{var r="p"===o.name||"div"===o.name||"tr"===o.name||"li"===o.name||"h"===o.name[0]&&o.name[1]>"0"&&o.name[1]<"7";r&&e&&"\n"!==e[e.length-1]&&(e+="\n"),o.children&&t(o.children),r&&"\n"!==e[e.length-1]?e+="\n":"td"!==o.name&&"th"!==o.name||(e+="\t")}}}(t||this.data.nodes),e},getRect:function(){var t=this;return new Promise(function(e,n){tt.createSelectorQuery().in(t).select("._root").boundingClientRect().exec(function(t){return t[0]?e(t[0]):n(Error("Root label not found"))})})},pauseMedia:function(){for(var t=(this._videos||[]).length;t--;)this._videos[t].pause()},setPlaybackRate:function(t){this.playbackRate=t;for(var e=(this._videos||[]).length;e--;)this._videos[e].playbackRate(t)},setContent:function(t,e){var n=this;this.imgList&&e||(this.imgList=[]),this._videos=[];var i={},r=new o(this).parse(t);if(e)for(var a=this.data.nodes.length,s=r.length;s--;)i["nodes[".concat(a+s,"]")]=r[s];else i.nodes=r;if(this.setData(i),this.selectComponent("#_root",function(t){t.root=n,n._hook("onLoad"),n.triggerEvent("load")}),this.data.lazyLoad||this.imgList._unloadimgs<this.imgList.length/2){var l=0,c=function t(e){e&&e.height||(e={}),e.height===l?n.triggerEvent("ready",e):(l=e.height,setTimeout(function(){n.getRect().then(t).catch(t)},350))};this.getRect().then(c).catch(c)}else this.imgList._unloadimgs||this.getRect().then(function(t){n.triggerEvent("ready",t)}).catch(function(){n.triggerEvent("ready",{})})},_hook:function(t){for(var e=r.length;e--;)this.plugins[e][t]&&this.plugins[e][t]()}}});