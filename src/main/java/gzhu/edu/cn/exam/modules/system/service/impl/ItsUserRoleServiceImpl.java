package gzhu.edu.cn.exam.modules.system.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import gzhu.edu.cn.exam.modules.system.entity.ItsUserRole;
import gzhu.edu.cn.exam.modules.system.mapper.ItsUserRoleMapper;
import gzhu.edu.cn.exam.modules.system.service.IItsUserRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author loading
 * @since 2021-11-22
 */
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class ItsUserRoleServiceImpl extends ServiceImpl<ItsUserRoleMapper, ItsUserRole> implements IItsUserRoleService {

}
