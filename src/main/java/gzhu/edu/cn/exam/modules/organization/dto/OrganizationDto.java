package gzhu.edu.cn.exam.modules.organization.dto;

import lombok.Data;

import java.util.List;

/**
 * @author Yinglei Jie on 2022/4/1
 */
@Data
public class OrganizationDto {

    /**
     * id
     */
    private String id;

    /**
     * 名称
     */
    private String name;

    /**
     * 子项目
     */
    private List<OrganizationDto> children;
}
