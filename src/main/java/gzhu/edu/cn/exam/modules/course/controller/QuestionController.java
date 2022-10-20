package gzhu.edu.cn.exam.modules.course.controller;

import gzhu.edu.cn.exam.modules.experiment.controller.LabController;
import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/course/question")
public class QuestionController {

    @Value("${file.uploadFolder}")
    private String uploadFolder;

    @Value("${file.staticAccessPath}")
    private String staticAccessPath;


    @PostMapping("imageUpload")
    @ResponseBody
    public Map<String,Object> imageupload(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();
        if (file.isEmpty()) {
            map.put("code",0);
            map.put("msg","文件为空");
        }
        String fileName = file.getOriginalFilename();  // 文件名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));  // 后缀名
        fileName = UUID.randomUUID() + suffixName; // 新文件名
        File dest = new File(uploadFolder +"images/"+ fileName);
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }
        try {
            file.transferTo(dest);
            map.put("code",0);
            map.put("msg","图片上传成功！");
            Image image = new Image();
            image.setSrc(staticAccessPath +"images/" + fileName);
            map.put("data",image);
        } catch (IOException e) {
            map.put("code",0);
            map.put("msg","图片上传异常！");
            e.printStackTrace();
        }
        return map;
    }

    @Data
    class Image{
        private String src;
        private String title;
    }

}
