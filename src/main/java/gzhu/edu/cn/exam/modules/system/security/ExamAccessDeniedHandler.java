package gzhu.edu.cn.exam.modules.system.security;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 访问被拒绝处理
 *
 * @author dingguozhu
 */
@Service
public class ExamAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException exception)
            throws IOException, ServletException {
        System.out.println("权限效验不通过。。。。。");
        request.getRequestDispatcher("/accessDenied").forward(request, response);
    }

}
