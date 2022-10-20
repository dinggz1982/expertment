package gzhu.edu.cn.exam.modules.system.controller;

import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.system.entity.Menu;
import gzhu.edu.cn.exam.modules.system.service.IMenuService;
import gzhu.edu.cn.exam.modules.system.vo.TreeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author loading
 * @since 2021-04-07
 */
@Controller
@RequestMapping("/system/menu/")
public class MenuController {

    @Autowired
    private IMenuService menuService;

    /**
     * 权限菜单主页
     *
     * @return
     */
    @GetMapping("index")
    public String index(Model model) {
        model.addAttribute("menus", menuService.getAll());
        return "system/menu/index";
    }

    @GetMapping("authorities")
    @ResponseBody
    public PageData<Menu> authorities() {
        PageData<Menu> menuPageData = new PageData<>();
        List<Menu> menus = this.menuService.getAll();
        menuPageData.setData(menus);
        menuPageData.setCode(0);
        menuPageData.setMsg("权限菜单");
        menuPageData.setCount(menus.size());
        return menuPageData;
    }

    /**
     * 保存或更新菜单
     *
     * @param menu
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(Menu menu) {
        ResonseData data = new ResonseData();
        try {
            if (menu.getId() != null && menu.getId() > 0) {
                this.menuService.updateById(menu);
                data.setMsg("成功更新菜单！");
            } else {
                this.menuService.save(menu);
                data.setMsg("成功保存菜单！");
            }
            data.setCode(200);
        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("保存菜单失败");
        }
        return data;
    }

    /**
     * 删除菜单
     *
     * @param id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResonseData delete(int id) {
        ResonseData data = new ResonseData();
        try {
            this.menuService.deleteByMenuId(id);
            data.setCode(200);
            data.setMsg("成功删除菜单！");
        } catch (Exception e) {
            data.setMsg("删除菜单失败");
            e.printStackTrace();
        }
        return data;
    }

    @GetMapping("authTree")
    @ResponseBody
    public List<TreeVo> authTree(int roleId) {
        return this.menuService.getAuthTreeByRoleId(roleId);
    }

    @PostMapping("saveAuth")
    @ResponseBody
    public ResonseData saveAuth(int roleId,String authIds){
        ResonseData data = new ResonseData();
        try {
            this.menuService.updateAuth(roleId,authIds);
            data.setCode(200);
            data.setMsg("更新权限成功！");
        } catch (Exception e) {
            data.setMsg("更新权限失败");
            e.printStackTrace();
        }
        return data;
    }

}
