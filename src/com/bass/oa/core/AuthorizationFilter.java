package com.bass.oa.core;

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

public class AuthorizationFilter implements Filter {
	private final static String USER_AUTH = "USER_AUTH";
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)res;
		UserModel user = (UserModel)request.getSession().getAttribute(USER_AUTH);
		
		if(user == null){
			System.out.println("用户未登录");
			request.getRequestDispatcher("/login.do").forward(request, response);
		}
		
		chain.doFilter(req, res);
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub
		
	}
}
