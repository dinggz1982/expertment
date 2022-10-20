package gzhu.edu.cn.exam.modules.organization.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import lombok.Data;

import java.util.Date;

/**
 * 学校类
 *
 * @author dingguozhu
 */
@Data
@TableName("org_school")
public class School extends BaseEntity {
    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    //学校名
    private String name;

    //学校地址
    private String address;

    //创建时间
    private Date createTime;

    //负责人
    private String attention;

    //负责人联系电话
    private String tel;

}
