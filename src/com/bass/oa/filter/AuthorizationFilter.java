package com.bass.oa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bass.oa.model.UserModel;
import com.bass.oa.service.ITestService;
import com.bass.oa.service.IUserService;

public class AuthorizationFilter implements Filter {
	private final static String EXCLUDE_URLS = "excludeUrls";
	private String excludeUrls; //不需要过滤的请求url
	
	private ITestService testService;
	
	public void setTestService(ITestService testService){
		this.testService = testService;
	}
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		//UserModel user = this.userService.getCurrentUser();
		System.out.println(this.testService.getMessage());
		/*if(user == null){
			System.out.println("用户未登录");
			request.getRequestDispatcher("/login.do").forward(request, response);
		}*/
		
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		this.excludeUrls = config.getInitParameter("");
	}
}
