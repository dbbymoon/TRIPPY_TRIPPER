package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class LoginAfterCheckInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
	
		HttpSession session = request.getSession();
		String  id = (String)session.getAttribute("memberId"); 
		if(id != null) {
			//로그인되어 있으면 로그인 화면에 접근하지 못하고 main화면으로 이동
			//log 이외의 요청 수행 가능
			response.sendRedirect(request.getContextPath()+"/main");
			return false;
		}else {
			//로그인 되어 있지 않음, 계속 진행
			return true;
		}
	}
	
}
