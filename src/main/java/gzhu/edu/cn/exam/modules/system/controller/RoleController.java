package gzhu.edu.cn.exam.modules.system.controller;


import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.system.entity.Role;
import gzhu.edu.cn.exam.modules.system.entity.User;
import gzhu.edu.cn.exam.modules.system.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author loading
 * @since 2021-04-06
 */
@Controller
@RequestMapping("/system/role/")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @GetMapping("index")
    public String index(){
        return "system/role/index";
    }

    /**
     * 用户分页
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    public PageData<Role> list(Role role, int page, int limit){
        return  this.roleService.getPage(page,limit,role);
    }

    /**
     * 保存或更新角色
     * @param role
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(Role role) {
        ResonseData data = new ResonseData();
        try {
            if(role.getId()!=null&&role.getId()>0){
                this.roleService.updateById(role);
                data.setMsg("成功更新角色！");
            }else {
                this.roleService.save(role);
                data.setMsg("成功保存角色！");
            }
            data.setCode(200);
        }catch (Exception e){
            e.printStackTrace();
            data.setMsg("保存角色失败");
        }
        return data;
    }

    /**
     * 删除角色
     * @param id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResonseData delete(int id){
        ResonseData data = new ResonseData();
        try{
            this.roleService.removeById(id);
            data.setCode(200);
            data.setMsg("成功删除角色！");
        }catch (Exception e){
            data.setMsg("删除角色失败");
            e.printStackTrace();
        }
        return data;
    }

}
