package gzhu.edu.cn.exam.modules.system.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import gzhu.edu.cn.exam.base.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.util.Set;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 
 * </p>
 *
 * @author loading
 * @since 2021-04-07
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("its_menu")
public class Menu extends BaseEntity implements Comparable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 菜单/按钮的名字
     */
    private String name;

    /**
     * 菜单图标
     */
    private String icon;

    /**
     * 路由
     */
    private String url;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 排序
     */
    private int orderNumber;

    /**
     * 1:按钮，0表示菜单
     */
    private Boolean type;

    /**
     * 父菜单的id
     */
    @TableField("parent_id")
    private Integer parentId;

    /**
     * 1:打开，0关闭
     */
    private Boolean open;

    //子菜单
    @TableField(exist = false)
    public Set<Menu> subMenus;

    @Override
    public int compareTo(Object obj) {
        Menu menu=(Menu)obj;
        if(this.getOrderNumber()==menu.getOrderNumber()){
            return 0;			//如果排序相同，那么两者就是相等的
        }else if(this.getOrderNumber()>menu.getOrderNumber()){
            return 1;			//如果排序大于传入学排序
        }else{
            return -1;			//如果排序小于传入学排序
        }

    }
}
