package gzhu.edu.cn.exam.modules.borrow.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.borrow.dto.InstrumentBorrowListDto;
import gzhu.edu.cn.exam.modules.borrow.dto.LabBorrowListDto;
import gzhu.edu.cn.exam.modules.borrow.enums.LabBorrowStatusEnum;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpInstrumentRecordMapper;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpLabRecordMapper;
import gzhu.edu.cn.exam.modules.experiment.service.ExpInstrumentRecordService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author Yinglei Jie on 2021/12/13
 */
@Slf4j
@Controller
@RequestMapping("/borrow/situation/")
public class BorrowSituationController {

    @Resource
    private ExpLabRecordMapper expLabRecordMapper;
    @Resource
    private ExpInstrumentRecordMapper expInstrumentRecordMapper;
    @Resource
    private ExpInstrumentRecordService expInstrumentRecordService;

    @GetMapping("/")
    public String index() {
        return "modules/borrow/borrow-situation";
    }


    @GetMapping("/getLabList")
    @ResponseBody
    public R getLabList(@RequestParam(value = "page", defaultValue = "1", required = false) Integer page,
                        @RequestParam(value = "limit", defaultValue = "10", required = false) Integer limit,
                        @RequestParam(required = false) Integer status) {
        IPage<LabBorrowListDto> pageInfo = new Page<>(page, limit);
        if (-1 == status) {
            status = null;
        }
        expLabRecordMapper.getApproveList(pageInfo, null, status);
        List<LabBorrowListDto> records = pageInfo.getRecords();
        if (!records.isEmpty()) {
            records.forEach(item -> item.setStatusName(LabBorrowStatusEnum.getDescById(item.getStatus())));
        }
        return R.ok().put("data", pageInfo);
    }

    @GetMapping("/updateReturnTime")
    @ResponseBody
    public R updateReturnTime(String id, String returnTime) {
//        log.error("id:{}", id);
//        log.error("returnTime:{}", returnTime);
        expInstrumentRecordService.updateReturnTime(id, returnTime);
        return R.ok("更新成功");
    }

    @GetMapping("/getInstrumentList")
    @ResponseBody
    public R getInstrumentList(@RequestParam(value = "page", defaultValue = "1", required = false) Integer page,
                               @RequestParam(value = "limit", defaultValue = "10", required = false) Integer limit,
                               @RequestParam(required = false) Integer status) {
        IPage<InstrumentBorrowListDto> pageInfo = new Page<>(page, limit);
        if (status == -1) {
            status = null;
        }
        expInstrumentRecordMapper.getInstrumentList(pageInfo, status);
        List<InstrumentBorrowListDto> records = pageInfo.getRecords();
        if (!records.isEmpty()) {
            records.forEach(item -> item.setStatusName(LabBorrowStatusEnum.getDescById(item.getStatus())));
        }
        return R.ok().put("data", pageInfo);
    }
}
