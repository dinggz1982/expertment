package gzhu.edu.cn.exam.modules.volunteer.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import gzhu.edu.cn.exam.modules.volunteer.entity.VolunteerRegister;
import gzhu.edu.cn.exam.modules.volunteer.vo.RegisterListRequestVo;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author loading
 * @since 2022-03-01
 */
public interface VolunteerRegisterMapper extends BaseMapper<VolunteerRegister> {

    IPage<VolunteerRegister> getRegisterDataPage(IPage<VolunteerRegister> pageData, RegisterListRequestVo vo);
}
