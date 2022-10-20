package gzhu.edu.cn.exam.base.exception;

/**
 * @author Yinglei Jie on 2022/3/8
 */
public class LabException extends RuntimeException {

    private Object data;


    public LabException(String message, Object data) {
        super(message);
        this.data = data;
    }

    public Object getData() {
        return data;
    }
}
