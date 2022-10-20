package gzhu.edu.cn.exam.modules.borrow.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import gzhu.edu.cn.exam.base.model.R;
import gzhu.edu.cn.exam.modules.borrow.dto.InstrumentBorrowListDto;
import gzhu.edu.cn.exam.modules.borrow.dto.LabBorrowListDto;
import gzhu.edu.cn.exam.modules.borrow.dto.SubmitApproveDto;
import gzhu.edu.cn.exam.modules.borrow.enums.LabBorrowStatusEnum;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpInstrumentRecordMapper;
import gzhu.edu.cn.exam.modules.experiment.mapper.ExpLabRecordMapper;
import gzhu.edu.cn.exam.modules.experiment.service.ExpInstrumentRecordService;
import gzhu.edu.cn.exam.modules.experiment.service.IExpLabRecordService;
import gzhu.edu.cn.exam.modules.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

import static gzhu.edu.cn.exam.modules.borrow.enums.ApproveTypeConstant.*;

/**
 * 实验室与仪器实验员审批前端控制器
 *
 * @author Yinglei Jie on 2021/12/12
 */
@Slf4j
@Controller
@RequestMapping("/borrow/experimenter/approve/")
public class BorrowExperimenterApproveController {


    @Resource
    private IUserService userService;
    @Resource
    private ExpLabRecordMapper expLabRecordMapper;
    @Resource
    private IExpLabRecordService expLabRecordService;
    @Resource
    private ExpInstrumentRecordMapper expInstrumentRecordMapper;
    @Resource
    private ExpInstrumentRecordService expInstrumentRecordService;

    @GetMapping("/")
    public String index() {
        return "modules/borrow/experimenter-approve";
    }

    @GetMapping("/getLabApproveList")
    @ResponseBody
    public R getApproveList(@RequestParam(value = "page", defaultValue = "1", required = false) Integer page,
                            @RequestParam(value = "limit", defaultValue = "10", required = false) Integer limit) {
        IPage<LabBorrowListDto> pageInfo = new Page<>(page, limit);
        expLabRecordMapper.getApproveList(pageInfo, null, LabBorrowStatusEnum.TEACHER_AGREE.getCode());
        List<LabBorrowListDto> records = pageInfo.getRecords();
        if (!records.isEmpty()) {
            records.forEach(item -> item.setStatusName(LabBorrowStatusEnum.getDescById(item.getStatus())));
        }
        return R.ok().put("data", pageInfo);
    }

    @GetMapping("/getInstrumentApproveList")
    @ResponseBody
    public R getInstrumentApproveList(@RequestParam(value = "page", defaultValue = "1", required = false) Integer page,
                                      @RequestParam(value = "limit", defaultValue = "10", required = false) Integer limit) {
        IPage<InstrumentBorrowListDto> pageInfo = new Page<>(page, limit);
        expInstrumentRecordMapper.getInstrumentApproveList(pageInfo, null, LabBorrowStatusEnum.TEACHER_AGREE.getCode());
        List<InstrumentBorrowListDto> records = pageInfo.getRecords();
        if (!records.isEmpty()) {
            records.forEach(item -> item.setStatusName(LabBorrowStatusEnum.getDescById(item.getStatus())));
        }
        return R.ok().put("data", pageInfo);
    }


    @PostMapping("/submitApprove")
    @ResponseBody
    public R submitApprove(@RequestBody @Validated SubmitApproveDto dto) {
        if (LAB.equals(dto.getType())) {
            //实验室单选审核
            expLabRecordService.experimenterApproveLabRecord(dto);
        } else if (INSTRUMENT.equals(dto.getType())) {
            //仪器审核（单选）
            expInstrumentRecordService.experimenterApproveInstrumentRecord(dto);
        } else if (LAB_LIST.equals(dto.getType())) {
            //实验室多选审核
            List<Integer> ids = dto.getIds();
            if (Objects.nonNull(ids) && !ids.isEmpty()) {
                SubmitApproveDto vo = new SubmitApproveDto();
                vo.setIsApprove(dto.getIsApprove());
                if (dto.getIsApprove() == 0) {
                    vo.setReason(dto.getReason());
                }
                ids.forEach(item -> {
                    vo.setId(item);
                    expLabRecordService.experimenterApproveLabRecord(vo);
                });
            }
//            expLabRecordService.experimenterApproveLabRecordList(dto);
        } else if (INSTRUMENT_LIST.equals(dto.getType())) {
            //仪器多选
            List<Integer> ids = dto.getIds();
            if (Objects.nonNull(ids) && !ids.isEmpty()) {
                SubmitApproveDto vo = new SubmitApproveDto();
                vo.setIsApprove(dto.getIsApprove());
                if (dto.getIsApprove() == 0) {
                    vo.setReason(dto.getReason());
                }
                ids.forEach(item -> {
                    vo.setId(item);
                    expInstrumentRecordService.experimenterApproveInstrumentRecord(vo);
                });
            }
//            expInstrumentRecordService.experimenterApproveInstrumentRecordList(dto);
        }
        return R.ok("提交成功");
    }

}
