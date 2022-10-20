package gzhu.edu.cn.exam.modules.system.vo;


/**
 * @program: exam
 * @description: 树
 * @author: 丁国柱
 * @create: 2021-04-12 22:35
 */

public class TreeVo {
    private int id;
    private String name;
    private int pId;
    private boolean open;
    private boolean checked;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }
}