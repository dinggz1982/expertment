package gzhu.edu.cn.exam.modules.system.exception;

import java.util.List;

/**
 * @author Yinglei Jie on 2021/12/26
 */
public class UserExistException extends RuntimeException {
    private List<String> existList;

    public UserExistException() {
        super();
    }


    public UserExistException(String message) {
        super(message);
    }

    public List<String> getExistList() {
        return existList;
    }

    public void setExistList(List<String> existList) {
        this.existList = existList;
    }
}
