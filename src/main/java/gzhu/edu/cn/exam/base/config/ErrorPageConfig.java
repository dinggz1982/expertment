package gzhu.edu.cn.exam.base.config;

import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.ErrorPageRegistrar;
import org.springframework.boot.web.server.ErrorPageRegistry;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;

@Configuration
public class ErrorPageConfig implements ErrorPageRegistrar {

	@Override
	public void registerErrorPages(ErrorPageRegistry registry) {
		ErrorPage error404 = new ErrorPage(HttpStatus.NOT_FOUND, "/404.html");
		ErrorPage error401 = new ErrorPage(HttpStatus.UNAUTHORIZED, "/401.html");
		ErrorPage error403 = new ErrorPage(HttpStatus.FORBIDDEN, "/403.html");
		ErrorPage error500 = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/500.html");
		registry.addErrorPages(error404, error500,error401,error403);
	}
}