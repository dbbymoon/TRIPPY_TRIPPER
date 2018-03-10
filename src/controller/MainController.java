package controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/main")
//main화면 요청
public class MainController {
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String main(HttpSession session, Model model) {
		return "main";
	}
}
