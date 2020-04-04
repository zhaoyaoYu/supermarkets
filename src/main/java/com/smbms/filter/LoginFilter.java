package com.smbms.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
@WebFilter(urlPatterns= {})
public class LoginFilter implements Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("过滤器方法");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpServletRequest=(HttpServletRequest)request;
		System.out.println("过滤器拦截非法请求");
		Object user = httpServletRequest.getSession().getAttribute("user");
		if(user==null) {
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}else {
			chain.doFilter(request, response);
		}
		
		
	}

	@Override
	public void destroy() {
		
	}

}
