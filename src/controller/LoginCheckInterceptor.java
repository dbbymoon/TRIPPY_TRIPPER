package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class LoginCheckInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//요청을 가로 챘는데...
		//session에 userid 라는 속성이 없으면, login 화면으로 돌려보냄
		HttpSession session = request.getSession();
		String  id = (String)session.getAttribute("memberId"); 
		if(id == null) {
			//로그인 되어 있지 않음, 요청 중단, 로그인 화면으로 보내기
			//log가 포함된 요청만 수행
			response.sendRedirect(request.getContextPath()+"/log/login");
			return false;
		}else {
			//로그인 되어 있음, 요청 계속 진행
			return true;
		}
	}
	
}
