/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.4.1 (2020-07-08)
 */
!function(r){"use strict";var n,t,e,o,u,i,c=tinymce.util.Tools.resolve("tinymce.PluginManager"),a=function(n){return function(){return n}},s=a(!1),f=a(!0),l=function(){return d},d=(n=function(n){return n.isNone()},{fold:function(n,t){return n()},is:s,isSome:s,isNone:f,getOr:e=function(n){return n},getOrThunk:t=function(n){return n()},getOrDie:function(n){throw new Error(n||"error: getOrDie called on none.")},getOrNull:a(null),getOrUndefined:a(undefined),or:e,orThunk:t,map:l,each:function(){},bind:l,exists:s,forall:f,filter:l,equals:n,equals_:n,toArray:function(){return[]},toString:a("none()")}),m=function(e){var n=a(e),t=function(){return o},r=function(n){return n(e)},o={fold:function(n,t){return t(e)},is:function(n){return e===n},isSome:f,isNone:s,getOr:n,getOrThunk:n,getOrDie:n,getOrNull:n,getOrUndefined:n,or:t,orThunk:t,map:function(n){return m(n(e))},each:function(n){n(e)},bind:r,exists:r,forall:r,filter:function(n){return n(e)?o:d},toArray:function(){return[e]},toString:function(){return"some("+e+")"},equals:function(n){return n.is(e)},equals_:function(n,t){return n.fold(s,function(n){return t(e,n)})}};return o},v=function(n){return null===n||n===undefined?d:m(n)},g=function(t){return function(n){return typeof n===t}},h=(o="string",function(n){return e=typeof(t=n),(null===t?"null":"object"==e&&(Array.prototype.isPrototypeOf(t)||t.constructor&&"Array"===t.constructor.name)?"array":"object"==e&&(String.prototype.isPrototypeOf(t)||t.constructor&&"String"===t.constructor.name)?"string":e)===o;var t,e}),p=g("boolean"),y=g("number"),w=function(n,t){for(var e=0,r=n.length;e<r;e++){t(n[e],e)}},b=Object.keys,N=function(n,t){for(var e=b(n),r=0,o=e.length;r<o;r++){var u=e[r];t(n[u],u)}},T=("undefined"!=typeof r.window?r.window:Function("return this;")(),function(n){return n.dom().nodeValue}),k=(u=3,function(n){return n.dom().nodeType===u}),A=function(n,t,e){!function(n,t,e){if(!(h(e)||p(e)||y(e)))throw r.console.error("Invalid call to Attr.set. Key ",t,":: Value ",e,":: Element ",n),new Error("Attribute value was not simple");n.setAttribute(t,e+"")}(n.dom(),t,e)},O=function(n,t){n.dom().removeAttribute(t)},C=function(n,t){var e,r,o=(e=t,null===(r=n.dom().getAttribute(e))?undefined:r);return o===undefined||""===o?[]:o.split(" ")},S=function(n){return n.dom().classList!==undefined},D=function(n,t){return o=t,u=C(e=n,r="class").concat([o]),A(e,r,u.join(" ")),!0;var e,r,o,u},E=function(n,t){return o=t,0<(u=function(n,t){for(var e=[],r=0,o=n.length;r<o;r++){var u=n[r];t(u,r)&&e.push(u)}return e}(C(e=n,r="class"),function(n){return n!==o})).length?A(e,r,u.join(" ")):O(e,r),!1;var e,r,o,u},L=function(n){0===(S(n)?n.dom().classList:C(n,"class")).length&&O(n,"class")},x=function(n){if(null===n||n===undefined)throw new Error("Node cannot be null or undefined");return{dom:a(n)}},V={fromHtml:function(n,t){var e=(t||r.document).createElement("div");if(e.innerHTML=n,!e.hasChildNodes()||1<e.childNodes.length)throw r.console.error("HTML does not have a single root node",n),new Error("HTML must have a single root node");return x(e.childNodes[0])},fromTag:function(n,t){var e=(t||r.document).createElement(n);return x(e)},fromText:function(n,t){var e=(t||r.document).createTextNode(n);return x(e)},fromDom:x,fromPoint:function(n,t,e){var r=n.dom();return v(r.elementFromPoint(t,e)).map(x)}},B={"\xa0":"nbsp","\xad":"shy"},P=function(n,t){var e="";return N(n,function(n,t){e+=t}),new RegExp("["+e+"]",t?"g":"")},_=P(B),j=P(B,!0),M=(i="",N(B,function(n){i&&(i+=","),i+="span.mce-"+n}),i),q="mce-nbsp",H=function(n){return'<span data-mce-bogus="1" class="mce-'+B[n]+'">'+n+"</span>"},F=function(n){var t=T(n);return k(n)&&t!==undefined&&_.test(t)},I=function(n,t){var e=[],r=function(n,t){for(var e=n.length,r=new Array(e),o=0;o<e;o++){var u=n[o];r[o]=t(u,o)}return r}(n.dom().childNodes,V.fromDom);return w(r,function(n){t(n)&&(e=e.concat([n])),e=e.concat(I(n,t))}),e},U=function(n){return"span"===n.nodeName.toLowerCase()&&n.classList.contains("mce-nbsp-wrap")},K=function(c,n){var t=I(V.fromDom(n),F);w(t,function(n){var t,e,r=n.dom().parentNode;if(U(r))t=V.fromDom(r),e=q,S(t)?t.dom().classList.add(e):D(t,e);else{for(var o=c.dom.encode(T(n)).replace(j,H),u=c.dom.create("div",null,o),i=void 0;i=u.lastChild;)c.dom.insertAfter(i,n.dom());c.dom.remove(n.dom())}})},R=function(t,n){var e=t.dom.select(M,n);w(e,function(n){U(n)?function(n,t){S(n)?n.dom().classList.remove(t):E(n,t);L(n)}(V.fromDom(n),q):t.dom.remove(n,!0)})},z=function(n){var t=n.getBody(),e=n.selection.getBookmark(),r=function(n,t){for(;n.parentNode;){if(n.parentNode===t)return n;n=n.parentNode}}(n.selection.getNode(),t);r=r!==undefined?r:t,R(n,r),K(n,r),n.selection.moveToBookmark(e)},G=function(n,t){var e,r,o=n.getBody(),u=n.selection;t.set(!t.get()),e=n,r=t.get(),e.fire("VisualChars",{state:r});var i=u.getBookmark();(!0===t.get()?K:R)(n,o),u.moveToBookmark(i)},J=tinymce.util.Tools.resolve("tinymce.util.Delay"),Q=function(e,r){return function(t){t.setActive(r.get());var n=function(n){return t.setActive(n.state)};return e.on("VisualChars",n),function(){return e.off("VisualChars",n)}}};!function W(){c.add("visualchars",function(n){var t,e,r,o,u,i,c,a,s,f,l,d=(t=!1,{get:function(){return t},set:function(n){t=n}});return r=d,(e=n).addCommand("mceVisualChars",function(){G(e,r)}),u=d,(o=n).ui.registry.addToggleButton("visualchars",{tooltip:"Show invisible characters",icon:"visualchars",onAction:function(){return o.execCommand("mceVisualChars")},onSetup:Q(o,u)}),o.ui.registry.addToggleMenuItem("visualchars",{text:"Show invisible characters",icon:"visualchars",onAction:function(){return o.execCommand("mceVisualChars")},onSetup:Q(o,u)}),i=n,c=d,a=J.debounce(function(){z(i)},300),!1!==i.getParam("forced_root_block")&&i.on("keydown",function(n){!0===c.get()&&(13===n.keyCode?z(i):a())}),f=d,(s=n).on("init",function(){var n=!s.getParam("visualchars_default_state",!1);f.set(n),G(s,f)}),l=d,{isEnabled:function(){return l.get()}}})}()}(window);