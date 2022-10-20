package gzhu.edu.cn.exam.modules.experiment.controller;

import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.experiment.entity.ExpType;
import gzhu.edu.cn.exam.modules.experiment.service.IExpTypeService;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @program: mix-tech
 * @description:实验类型
 * @author: 丁国柱
 * @create: 2021-05-15 22:46
 */
@Controller
@RequestMapping("/experiment/type")
public class ExpTypeController {

    @Autowired
    private IExpTypeService expTypeService;

    @Value("${file.uploadFolder}")
    private String uploadFolder;

    @Value("${file.staticAccessPath}")
    private String staticAccessPath;


    /**
     * 实验类型管理页面
     *
     * @return
     */
    @GetMapping({"", "/"})
    public String index() {
        return "modules/experiment/expType";
    }


    /**
     * 图片上传
     *
     * @param file
     * @param request
     * @return
     */
    @PostMapping(value = "/uploadImages")
    @ResponseBody
    public Map<String, Object> fileUpload(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();

        if (file.isEmpty()) {
            map.put("code", 0);
            map.put("msg", "文件为空空");
        }
        String fileName = file.getOriginalFilename();  // 文件名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));  // 后缀名
        fileName = UUID.randomUUID() + suffixName; // 新文件名
        File dest = new File(uploadFolder + fileName);
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }
        try {
            file.transferTo(dest);
            map.put("code", 0);
            map.put("msg", "图片上传成功！");
            Image image = new Image();
            image.setSrc(staticAccessPath + fileName);
            map.put("data", image);
        } catch (IOException e) {
            map.put("code", 0);
            map.put("msg", "图片上传异常！");
            e.printStackTrace();
        }
        return map;
    }


    /**
     * 保存或更新实验类型
     *
     * @param expType
     * @return
     */
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(ExpType expType) {
        ResonseData data = new ResonseData();
        try {
            if (expType.getId() != null && expType.getId() > 0) {
                this.expTypeService.updateById(expType);
                data.setMsg("成功更新实验类型！");
            } else {
                this.expTypeService.save(expType);
                data.setMsg("成功保存实验类型！");
            }
            data.setCode(200);
        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("保存实验类型失败");
        }
        return data;
    }

    /**
     * 实验类型分页
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    public PageData<ExpType> list(ExpType expType, int page, int limit) {
        return this.expTypeService.getPage(page, limit, expType);
    }


    /**
     * 删除用户
     *
     * @param id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResonseData delete(int id) {
        ResonseData data = new ResonseData();
        try {
            this.expTypeService.removeById(id);
            data.setCode(200);
            data.setMsg("成功删除实验类型！");
        } catch (Exception e) {
            data.setMsg("删除用户实验类型");
            e.printStackTrace();
        }
        return data;
    }

    @GetMapping("/getExpTypeList")
    @ResponseBody
    public R getExpTypeList() {
        List<ExpType> list = expTypeService.list();
        return R.ok().put("data", list);
    }

    @Data
    class Image {
        private String src;
        private String title;
    }


}
