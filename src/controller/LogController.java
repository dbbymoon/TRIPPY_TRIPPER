package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import model.TMember;
import service.TMemberService;

@Controller
@RequestMapping("/log/*")
public class LogController {

	@Autowired
	TMemberService tMemberService;

	/*LOGIN*/

	// 로그인 폼 요청 (프로젝트 첫 화면)
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginForm() {
		return "login";
	}

	// 로그인 요청
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String memberId, String memberPass, HttpSession session, Model model) {
		String LogResult = tMemberService.selectOneById(memberId, memberPass);
		TMember tMember = tMemberService.selectMember(memberId);
		if (LogResult.equals("성공")) {
			//로그인 성공
			session.setAttribute("memberId", memberId);
			session.setAttribute("memberProfile", tMember.getMemberProfile());
			return "redirect:../main";

		} else if (LogResult.equals("비밀번호")){
			// 비밀번호가 틀림
			// 비밀번호가 틀렸다는 안내와 함께 로그인 페이지로 돌아옴
			model.addAttribute("msg", "비밀번호가 틀렸습니다.");
			model.addAttribute("url", "../log/login");
			
		}else if (LogResult.equals("아이디")){
			// 아직 가입하지 않은 아이디
			// 가입하지 않은 아이디라고 안내후 로그인 페이지로 돌아간다.
			model.addAttribute("msg", "존재하지 않는 아이디입니다.");
			model.addAttribute("url", "../log/login");
		}
		return "result";
	}

	/* ***************************************************************************** */
	/* FIND ID/PW */
	
	// 아이디/비밀번호 찾기 폼 요청
	@RequestMapping(value = "/find", method = RequestMethod.GET)
	public String findForm() {
		// System.out.println("로그인 화면 요청");
		return "find";
	}

	//아이디 찾기 요청
	@RequestMapping(value = "/findId",method = RequestMethod.POST)
	public String findId(String memberName, String memberEmail,Model model) {

	    String result = tMemberService.findId(memberName, memberEmail);

	    if(result=="회원 없음") {
	        //이메일 존재하지 않음
	        model.addAttribute("msg", "존재하지 않는 회원입니다");
	        model.addAttribute("url","find");
	        return "result";
	    }else if(result=="불일치") {
	        //이름 불일치
	        model.addAttribute("msg","입력하신 정보와 일치하지 않습니다");
	        model.addAttribute("url","find");
	        return "result";
	    }else {
	        //아이디 찾기 성공 : 아이디 반환
	        model.addAttribute("memberId",result);
	        return "findResult";
	    }

	}

	//비밀번호 찾기 요청
	@RequestMapping(value = "/findPw",method = RequestMethod.POST)
	public String findPw(String memberId, String memberName, String memberEmail,Model model) {
	    String result = tMemberService.findPw(memberId, memberName, memberEmail);

	    if(result=="회원 없음") {
	        //아이디 존재하지 않음
	        model.addAttribute("msg", "존재하지 않는 회원입니다");
	        model.addAttribute("url","find");
	        return "result";
	    }else if(result=="불일치") {
	        //이름 불일치
	        model.addAttribute("msg","입력하신 정보와 일치하지 않습니다");
	        model.addAttribute("url","find");
	        return "result";
	    }else {
	        //비밀번호 찾기 성공 : 비밀번호 반환
	        model.addAttribute("memberPass",result);
	        return "findResult";
	    }

	}

	/* ***************************************************************************** */
	/*JOIN*/
	
	// 회원가입 폼 요청
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinForm() {
	    return "join";
	}

	// 회원가입 - ID 체크
	@RequestMapping(value = "/joinIdCheck", method = RequestMethod.POST)
	@ResponseBody
	public String joinIdCheck(Model model, String memberId) {
	    System.out.println("아이디 중복 확인 요청");

	    boolean result = tMemberService.checkId(memberId);

	    return String.valueOf(result);
	}

	// 회원가입 - Email 체크
	@RequestMapping(value = "/joinEmailCheck", method = RequestMethod.POST)
	@ResponseBody
	public String joinEmailCheck(Model model, String memberEmail) {
	    System.out.println("이메일 중복 확인 요청");

	    boolean result = tMemberService.checkEmail(memberEmail);

	    return String.valueOf(result);
	}

	// 가입 요청1 - 필수사항 (step 1) 입력 후 join detail 페이지로 이동
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(RedirectAttributes rttr, TMember member) {
	    System.out.println("회원가입 step 1 요청");

	    if (tMemberService.joinMember(member)) {
	        // 가입 step 1 완료
	        // model.addAttribute("memberId", member.getMemberId());
	        rttr.addFlashAttribute("memberId", member.getMemberId());
	        return "redirect:joinDetail";
	    }
	    return "join";
	}

	// 가입 요청2 - 선택사항 (step 2) Form 요청
	@RequestMapping(value = "/joinDetail", method = RequestMethod.GET)
	public String joinDetailForm(RedirectAttributes rttr) {
	    return "joinDetail";
	}


	@RequestMapping(value = "joinProfile", method = RequestMethod.POST)
	@ResponseBody
	public String JoinProfileUpdate(HttpSession session, HttpServletRequest request, Model model) throws Exception {
	    System.out.println("회원가입 step 2 - 프로필 업데이트 요청");

	    String id = request.getParameter("id");
	    MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
	    MultipartFile multipartFile = multipartRequest.getFile("profile");
	    String fullName = tMemberService.joinProfile(id, multipartFile);

	    if (fullName == "fail") {
	        // 가입 step 2 완료
	        return "fail";

	    } else {
	        return fullName;
	    }

	}

	// 가입 요청2 - 선택사항 (step 2)
	@RequestMapping(value = "/joinDetail", method = RequestMethod.POST)
	public String joinDetail(Model model, TMember tMember, MultipartFile file) {
	    System.out.println("회원가입 step 2 요청");

	    if (tMemberService.joinDetailMember(tMember, file)) {
	        // 가입 step 2 완료
	        model.addAttribute("msg", "회원가입 완료!");
	        model.addAttribute("state", "success");
	        model.addAttribute("url", "../log/login");

	    } else {
	        model.addAttribute("msg", "회원가입 실패!");
	        model.addAttribute("state", "fail");
	        model.addAttribute("url", "../log/join");
	    }

	    return "result";
	}
	
	// 가입 요청1 Google - 필수사항 (step 1) 입력 후 join detail 페이지로 이동
	@RequestMapping(value = "/joinGoogle")
	public String joinByGoogle(Model model, TMember member) {
		System.out.println(member);
	
		model.addAttribute("memberId", member.getMemberId());
		model.addAttribute("memberName", member.getMemberName());
		model.addAttribute("memberEmail", member.getMemberEmail());

		return "join";
	}
}
