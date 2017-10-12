package com.bass.oa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.bass.oa.model.UserModel;
import com.bass.oa.service.IUserService;

public class AuthorizationFilter implements Filter {
	private final static String BEAN_USERSERVICE = "userService";
	private final static String EXCLUDE_URLS = "excludeUrls";
	private String excludeUrls; //不需要过滤的请求url
	
	private IUserService userService;
	
	public void setUserService(IUserService userService){
		this.userService = userService;
	}
	
	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		UserModel user = this.userService.getCurrentUser();
		
		if(user == null){
			System.out.println("用户未登录");
			request.getRequestDispatcher("/login.do").forward(request, response);
		}
		
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		//获取排除过滤的连接
		this.excludeUrls = config.getInitParameter(EXCLUDE_URLS);
		
		//手动注入Spring bean
		ServletContext sc = config.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(sc);
		this.userService = (IUserService)context.getBean(BEAN_USERSERVICE);
	}
}
