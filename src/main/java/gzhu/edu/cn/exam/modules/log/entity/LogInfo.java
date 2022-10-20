package gzhu.edu.cn.exam.modules.log.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;

import java.util.Date;

/**
 * 日志记录
 * @author dingguozhu
 *
 */
@Data
public class LogInfo extends BaseEntity {

    @TableId(value = "id", type = IdType.AUTO)
	private long id;
	
	private String username;

    private String url;

    private Integer time;
    
    private Date createTime;

    private String method;

    private String params;
    
    private String operation;

    private String message;

    private String ip;

}
