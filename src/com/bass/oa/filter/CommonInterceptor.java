package com.bass.oa.filter;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bass.oa.core.ContextHelper;

@Component
public class CommonInterceptor extends HandlerInterceptorAdapter {
	private ContextHelper _context = ContextHelper.getInstance();

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// Cookie cookie = new Cookie("userToken", "test Cookie");
		// cookie.setMaxAge(30 * 60); 
		// 30分钟 
		// cookie.setPath("/");									
		// response.addCookie(cookie);

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		String code = "oa.name";
		String codePrefix = "oa";
		StringBuffer codeBuffer = new StringBuffer(codePrefix);
		String url = request.getServletPath();
		Pattern pattern = Pattern.compile("\\w+(?=\\.|\\/)");
		Matcher matcher = pattern.matcher(url);
		
		while(matcher.find()){
			codeBuffer.append(".");
			codeBuffer.append(matcher.group());
		}
		
		if(!codeBuffer.toString().equals(codePrefix)){
			code = codeBuffer.toString();
		}
		
		request.setAttribute("pageTitle", _context.getMessage(code));
	}
	
	public static void main(String[] args){
		Pattern pattern = Pattern.compile("Windows (?!95|98|NT|2000)");
		Matcher matcher = pattern.matcher("Windows XP");

		if(matcher.find()){
			System.out.println(matcher.group(0));
			System.out.println(matcher.group(1));
		}
		/*while(matcher.find()){
			System.out.println(matcher.group());
		}*/		
	}
}
