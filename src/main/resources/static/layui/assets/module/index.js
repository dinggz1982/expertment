/** EasyWeb iframe v3.1.6 date:2019-02-08 License By http://easyweb.vip */
layui.define(["layer", "element", "admin"], function (r) {
    var c = layui.jquery;
    var q = layui.layer;
    var b = layui.element;
    var k = layui.admin;
    var o = k.setter;
    var a = ".layui-layout-admin>.layui-header";
    var m = ".layui-layout-admin>.layui-side>.layui-side-scroll";
    var i = ".layui-layout-admin>.layui-body";
    var l = i + ">.layui-tab";
    var p = i + ">.layui-body-header";
    var h = "admin-pagetabs";
    var n = "admin-side-nav";
    var j = {};
    var e = false;
    var f = {homeUrl: undefined, mTabPosition: undefined, mTabList: []};
    f.loadView = function (x) {
        var u = x.menuName;
        var v = x.menuPath;
        if (!v) {
            q.msg("url不能为空", {icon: 2, anim: 6});
            return
        }
        if (o.pageTabs) {
            var t;
            // // console.log('open:', c(l + ">.layui-tab-title>li"))
            c(l + ">.layui-tab-title>li").each(function () {
                if (c(this).attr("lay-id") === v) {
                    t = true;
                    return false
                }
            });
            if (!t) {
                if ((f.mTabList.length + 1) >= o.maxTabNum) {
                    q.msg("最多打开" + o.maxTabNum + "个选项卡", {icon: 2, anim: 6});
                    k.activeNav(f.mTabPosition);
                    return
                }
                e = true;
                b.tabAdd(h, {
                    id: v,
                    title: '<span class="title">' + (u ? u : "") + "</span>",
                    content: '<iframe lay-id="' + v + '" src="' + v + '" frameborder="0" class="admin-iframe"></iframe>'
                });
                (v !== f.homeUrl) && f.mTabList.push(x);
                (o.cacheTab) && k.putTempData("indexTabs", f.mTabList)
            }
            b.tabChange(h, v)
        } else {
            k.activeNav(v);
            var s = c(i + ">div>.admin-iframe");
            if (s.length <= 0) {
                var w = '<div class="layui-body-header">';
                w += '      <span class="layui-body-header-title"></span>';
                w += '      <span class="layui-breadcrumb pull-right" lay-filter="admin-body-breadcrumb" style="visibility: visible;"></span>';
                w += "   </div>";
                w += '   <div style="-webkit-overflow-scrolling: touch;">';
                w += '      <iframe lay-id="' + v + '" src="' + v + '" frameborder="0" class="admin-iframe"></iframe>';
                w += "   </div>";
                c(i).html(w)
            } else {
                s.attr("lay-id", v);
                s.attr("src", v);
                f.setTabTitle(u)
            }
            c('[lay-filter="admin-body-breadcrumb"]').html(f.getBreadcrumbHtml(v));
            f.setTabTitle(f.homeUrl !== v ? u : undefined);
            f.mTabList.splice(0, f.mTabList.length);
            if (v !== f.homeUrl) {
                f.mTabList.push(x);
                f.mTabPosition = v
            } else {
                f.mTabPosition = undefined
            }
            if (o.cacheTab) {
                k.putTempData("indexTabs", f.mTabList);
                k.putTempData("tabPosition", f.mTabPosition)
            }
        }
        (k.getPageWidth() <= 768) && k.flexible(true)
    };
    f.cleanAll = function () {
        var ids = []
        // // console.log('o.pageTabs', o.pageTabs)
        // // console.log('fjeiwoqj:', top.layui.jquery(l + ">.layui-tab-title>li"))
        if (o.pageTabs) {
            // // console.log('o.pageTabs', o.pageTabs)
            // // console.log('fjeiwoqj:', c(l + ">.layui-tab-title>li"))
            top.layui.jquery(l + ">.layui-tab-title>li").each(function () {
                // // console.log('each:item:', c(this).attr("lay-id"))
                ids.push(c(this).attr("lay-id"))
            });
            // // console.log('ids:', ids)
            // // console.log('ids:', ids.length)
            if (ids.length > 0) {
                ids.forEach(item => {
                    // // console.log('foreach:', item)
                    if (item !== '/system/user/updateUserInfoPage') {
                        top.layui.index.closeTab(item)
                    }
                    // b.tabDelete(h, item)
                })
            }
        }
    };
    f.loadHome = function (w) {
        var v = k.getTempData("indexTabs");
        var u = k.getTempData("tabPosition");
        f.homeUrl = w.menuPath;
        f.loadView(w);
        if (!o.pageTabs) {
            k.activeNav(f.homeUrl)
        }
        if (w.loadSetting === undefined || w.loadSetting) {
            if (o.cacheTab && v) {
                var s = -1;
                for (var t = 0; t < v.length; t++) {
                    if (o.pageTabs && !w.onlyLast) {
                        f.loadView(v[t])
                    }
                    if (v[t].menuPath === u) {
                        s = t
                    }
                }
                if (s != -1) {
                    setTimeout(function () {
                        f.loadView(v[s]);
                        if (!o.pageTabs) {
                            k.activeNav(u)
                        }
                    }, 150)
                }
            }
        }
    };
    f.openTab = function (s) {
        if (window !== top && !k.isTop() && top.layui && top.layui.index) {
            top.layui.index.openTab(s);
            return
        }
        s.end && (j[s.url] = s.end);
        f.loadView({menuPath: s.url, menuName: s.title})
    };
    f.closeTab = function (s) {
        // console.log('f.closeTab', s)
        if (window != top && !k.isTop() && top.layui && top.layui.index) {
            top.layui.index.closeTab(s);
            return
        }
        b.tabDelete(h, s)
    };
    f.setTabCache = function (s) {
        if (window != top && !k.isTop() && top.layui && top.layui.index) {
            top.layui.index.setTabCache(s);
            return
        }
        k.putSetting("cacheTab", s);
        if (s) {
            k.putTempData("indexTabs", f.mTabList);
            k.putTempData("tabPosition", f.mTabPosition)
        } else {
            f.clearTabCache()
        }
    };
    f.clearTabCache = function () {
        k.putTempData("indexTabs", undefined);
        k.putTempData("tabPosition", undefined)
    };
    f.setTabTitle = function (t, s) {
        if (window != top && !k.isTop() && top.layui && top.layui.index) {
            top.layui.index.setTabTitle(t, s);
            return
        }
        if (o.pageTabs) {
            t || (t = "");
            s || (s = c(l + ">.layui-tab-title>li.layui-this").attr("lay-id"));
            s && c(l + '>.layui-tab-title>li[lay-id="' + s + '"] .title').html(t)
        } else {
            if (t) {
                c(p + ">.layui-body-header-title").html(t);
                c(p).addClass("show");
                c(a).css("box-shadow", "0 1px 0 0 rgba(0, 0, 0, .03)")
            } else {
                c(p).removeClass("show");
                k.util.removeStyle(a, "box-shadow")
            }
        }
    };
    f.setTabTitleHtml = function (s) {
        if (window != top && !k.isTop() && top.layui && top.layui.index) {
            top.layui.index.setTabTitleHtml(s);
            return
        }
        if (!o.pageTabs) {
            if (s) {
                c(p).addClass("show");
                c(p).html(s)
            } else {
                c(p).removeClass("show")
            }
        }
    };
    f.getBreadcrumb = function (s) {
        s || (s = c(i + ">div>.admin-iframe").attr("lay-id"));
        var u = [];
        var t = c(m).find('[lay-href="' + s + '"]');
        u.push(t.text().replace(/(^\s*)|(\s*$)/g, ""));
        while (true) {
            t = t.parent("dd").parent("dl").prev("a");
            if (t.length === 0) {
                break
            }
            u.unshift(t.text().replace(/(^\s*)|(\s*$)/g, ""))
        }
        return u
    };
    f.getBreadcrumbHtml = function (s) {
        var v = f.getBreadcrumb(s);
        var u = '<a ew-href="' + f.homeUrl + '">首页</a>';
        for (var t = 0; t < v.length - 1; t++) {
            u += '<span lay-separator="">/</span><a><cite>' + v[t] + "</cite></a>"
        }
        return u
    };
    var g = ".layui-layout-admin .site-mobile-shade";
    if (c(g).length <= 0) {
        c(".layui-layout-admin").append('<div class="site-mobile-shade"></div>')
    }
    c(g).click(function () {
        k.flexible(true)
    });
    if (o.pageTabs && c(l).length <= 0) {
        var d = '<div class="layui-tab" lay-allowClose="true" lay-filter="' + h + '">';
        d += '      <ul class="layui-tab-title"></ul>';
        d += '      <div class="layui-tab-content"></div>';
        d += "   </div>";
        d += '   <div class="layui-icon admin-tabs-control layui-icon-prev" ew-event="leftPage"></div>';
        d += '   <div class="layui-icon admin-tabs-control layui-icon-next" ew-event="rightPage"></div>';
        d += '   <div class="layui-icon admin-tabs-control layui-icon-down">';
        d += '      <ul class="layui-nav" lay-filter="admin-pagetabs-nav">';
        d += '         <li class="layui-nav-item" lay-unselect>';
        d += '            <dl class="layui-nav-child layui-anim-fadein">';
        d += '               <dd ew-event="closeThisTabs" lay-unselect><a>关闭当前标签页</a></dd>';
        d += '               <dd ew-event="closeOtherTabs" lay-unselect><a>关闭其它标签页</a></dd>';
        d += '               <dd ew-event="closeAllTabs" lay-unselect><a>关闭全部标签页</a></dd>';
        d += "            </dl>";
        d += "         </li>";
        d += "      </ul>";
        d += "   </div>";
        c(i).html(d);
        b.render("nav", "admin-pagetabs-nav")
    }
    b.on("nav(" + n + ")", function (v) {
        var u = c(v);
        var w = u.attr("lay-id");
        var s = u.attr("lay-href");
        w || (w = s);
        if (s && s !== "javascript:;") {
            var t = u.attr("ew-title");
            t || (t = u.text().replace(/(^\s*)|(\s*$)/g, ""));
            f.loadView({menuId: w, menuPath: s, menuName: t})
        }
    });
    b.on("tab(" + h + ")", function () {
        var t = c(this).attr("lay-id");
        f.mTabPosition = (t !== f.homeUrl ? t : undefined);
        if (o.cacheTab) {
            k.putTempData("tabPosition", f.mTabPosition)
        }
        k.activeNav(t);
        k.rollPage("auto");
        var s = c(l).attr("lay-autoRefresh");
        if (s === "true" && !e) {
            k.refresh(t)
        }
        e = false
    });
    b.on("tabDelete(" + h + ")", function (u) {
        var s = f.mTabList[u.index - 1];
        if (s) {
            var t = s.menuPath;
            f.mTabList.splice(u.index - 1, 1);
            if (o.cacheTab) {
                k.putTempData("indexTabs", f.mTabList)
            }
            j[t] && j[t].call()
        }
        if (c(l + ">.layui-tab-title>li.layui-this").length <= 0) {
            c(l + ">.layui-tab-title>li:last").trigger("click")
        }
    });
    c(document).off("click.navMore").on("click.navMore", "[nav-bind]", function () {
        var s = c(this).attr("nav-bind");
        c('ul[lay-filter="' + n + '"]').addClass("layui-hide");
        c('ul[nav-id="' + s + '"]').removeClass("layui-hide");
        c(a + ">.layui-nav .layui-nav-item").removeClass("layui-this");
        c(this).parent(".layui-nav-item").addClass("layui-this");
        if (k.getPageWidth() <= 768) {
            k.flexible(false)
        }
    });
    if (o.openTabCtxMenu && o.pageTabs) {
        layui.use("contextMenu", function () {
            var s = layui.contextMenu;
            if (!s) {
                return
            }
            c(l + ">.layui-tab-title").off("contextmenu.tab").on("contextmenu.tab", "li", function (u) {
                var t = c(this).attr("lay-id");
                s.show([{
                    icon: "layui-icon layui-icon-refresh", name: "刷新当前", click: function () {
                        b.tabChange(h, t);
                        var v = c(l).attr("lay-autoRefresh");
                        if (!v || v !== "true") {
                            k.refresh(t)
                        }
                    }
                }, {
                    icon: "layui-icon layui-icon-close-fill ctx-ic-lg", name: "关闭当前", click: function () {
                        k.closeThisTabs(t)
                    }
                }, {
                    icon: "layui-icon layui-icon-unlink", name: "关闭其他", click: function () {
                        k.closeOtherTabs(t)
                    }
                }, {
                    icon: "layui-icon layui-icon-close ctx-ic-lg", name: "关闭全部", click: function () {
                        k.closeAllTabs()
                    }
                }], u.clientX, u.clientY);
                return false
            })
        })
    }
    r("index", f)
});
