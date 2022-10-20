package gzhu.edu.cn.exam.modules.experiment.controller;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import gzhu.edu.cn.exam.base.model.PageData;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.base.model.ResonseData;
import gzhu.edu.cn.exam.modules.experiment.entity.Lab;
import gzhu.edu.cn.exam.modules.experiment.service.ILabService;
import gzhu.edu.cn.exam.modules.experiment.vo.LabSearchPageVo;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @program: mix-tech
 * @description:
 * @author: 丁国柱
 * @create: 2021-05-15 22:46
 */
@Slf4j
@Controller
@RequestMapping("experiment/lab")
public class LabController {

    @Resource
    private ILabService labService;

    @Value("${file.uploadFolder}")
    private String uploadFolder;

    @Value("${file.staticAccessPath}")
    private String staticAccessPath;

    public static String PREFIX = "/resource/lab/picture/";


    /**
     * 实验室管理页面
     *
     * @return
     */
    @GetMapping({"", "/"})
    public String index() {
        return "modules/experiment/lab-vue";
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
        Map<String, Object> map = new HashMap<>(16);
        if (file.isEmpty()) {
            map.put("code", 0);
            map.put("msg", "文件为空空");
        }
        // 文件名
        String fileName = file.getOriginalFilename();
        // 后缀名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));
        // 新文件名
        fileName = UUID.randomUUID() + suffixName;
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

    @PostMapping("/saveOrUpdateAdmin")
    @ResponseBody
    public R saveOrUpdateAdmin(@RequestBody @Validated Lab lab) {
        if (lab.getId() != null && lab.getId() > 0) {
            this.labService.updateById(lab);
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            lab.setCreateDate(sdf.format(new Date()));
            this.labService.save(lab);
        }
        return R.ok();
    }

    /**
     * 保存或更新实验室
     *
     * @param lab
     * @return
     */
    @PostMapping("/saveOrUpdate")
    @ResponseBody
    public ResonseData saveOrUpdate(Lab lab) {
        ResonseData data = new ResonseData();
        try {
            if (lab.getId() != null && lab.getId() > 0) {
                this.labService.updateById(lab);
                data.setMsg("成功更新实验室！");
            } else {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                lab.setCreateDate(sdf.format(new Date()));
                this.labService.save(lab);
                data.setMsg("成功保存实验室！");
            }
            data.setCode(200);
        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("保存实验室失败");
        }
        return data;
    }

    /**
     * 实验室分页
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("list.json")
    @ResponseBody
    public PageData<Lab> list(Lab lab, int page, int limit) {

        return this.labService.getPage(page, limit, lab);
    }

    @RequestMapping("/list")
    @ResponseBody
    public R listLab(@RequestBody LabSearchPageVo vo) {
        return R.ok().put("data", labService.getLabPage(vo));
    }

    @RequestMapping("/deleteAdmin/{id}")
    @ResponseBody
    public R deleteAdmin(@PathVariable Integer id) {
        if (id != 4) {
            labService.removeById(id);
            return R.ok();
        } else {
            return R.error("无法删除该系统实验室");
        }
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
            if (id != 4) {
                labService.removeById(id);
                data.setCode(200);
                data.setMsg("成功删除实验室！");
            } else {
                data.setMsg("无法删除该系统实验室");
            }
        } catch (Exception e) {
            data.setMsg("删除用户实验室");
            e.printStackTrace();
        }
        return data;
    }

    @RequestMapping("/updateFrontShow/{id}/{value}")
    @ResponseBody
    public R updateFrontShow(@PathVariable String id, @PathVariable String value) {
        LambdaUpdateWrapper<Lab> w = new LambdaUpdateWrapper<>();
        w.eq(Lab::getId, id).set(Lab::getFrontShow, value);
        labService.update(w);
        return R.ok();
    }

    @RequestMapping("/getLabPicture/{path}")
    @ResponseBody
    public byte[] getLabPicture(@PathVariable String path) throws Exception {
        File file = new File(PREFIX + path);
        FileInputStream inputStream = new FileInputStream(file);
        byte[] bytes = new byte[inputStream.available()];
        inputStream.read(bytes, 0, inputStream.available());
        return bytes;
    }

    @PostMapping("/updateLabSort")
    @ResponseBody
    public R updateLabSort(@RequestBody Lab lab) {
        labService.updateLabSort(lab);
        return R.ok();
    }

    @RequestMapping("/saveLabPicture")
    @ResponseBody
    public R saveLabPicture(MultipartFile file) throws IOException {
        File fileDir = new File(PREFIX);
        if (!fileDir.exists()) {
            fileDir.mkdirs();
        }
        log.error("绝对路径为：{}", fileDir.getAbsolutePath());
        InputStream inputStream = file.getInputStream();
        String contentType = file.getContentType();
        Assert.isTrue(Objects.equals("image/png", contentType) || Objects.equals("image/jpeg", contentType), "请上传图片");
        String originalFilename = file.getOriginalFilename();
        Assert.notNull(originalFilename, "文件名不能为空");
        int i = originalFilename.lastIndexOf(".");
        Assert.isTrue(i > 0, "请上传图片");
        String uuid = UUID.randomUUID().toString();
        String fileName = uuid + originalFilename.substring(i);
        BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(PREFIX + File.separator + fileName));
        byte[] bs = new byte[1024];
        int len;
        while ((len = inputStream.read(bs)) != -1) {
            bos.write(bs, 0, len);
        }
        bos.flush();
        bos.close();
        return R.ok().put("data", "/experiment/lab/getLabPicture/" + fileName);
    }


    @Data
    class Image {
        private String src;
        private String title;
    }

}
