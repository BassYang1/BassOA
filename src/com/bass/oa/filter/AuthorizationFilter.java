package com.bass.oa.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.bass.oa.model.po.UserModel;
import com.bass.oa.service.IUserService;

public class AuthorizationFilter implements Filter {
	private final static String BEAN_USERSERVICE = "userService";
	private final static String EXCLUDE_URLS = "excludeUrls";
	private final static String EXCLUDE_URLS_SEPARATOR = ",";
	private final static String REQUEST_URI_SEPARATOR = "/";
	private List<String> excludeUrls; //不需要过滤的请求url
	
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
		String url = ((HttpServletRequest)request).getRequestURI();
		
		if(user == null || !isExcludedUrl(url)){
			System.out.println("用户未登录");
			request.getRequestDispatcher("/login.do").forward(request, response);
		}
		
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		//获取排除过滤的连接
		String urls = config.getInitParameter(EXCLUDE_URLS);
		urls = urls.isEmpty() ? "" : urls;
		this.excludeUrls = Arrays.asList(urls.split(EXCLUDE_URLS_SEPARATOR));
		
		//手动注入Spring bean
		ServletContext sc = config.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(sc);
		this.userService = (IUserService)context.getBean(BEAN_USERSERVICE);
	}
	
	/*
	 * 判断请求URL是否被排除拦截
	 */
	private boolean isExcludedUrl(String url){
		String[] urls = url.split(REQUEST_URI_SEPARATOR);
		
		return urls.length <= 0 || this.excludeUrls.contains(urls[urls.length - 1]);
	}
}
