package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSplitPaneUI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import model.Companion;
import model.Itinerary;
import model.Matching;
import model.TMember;
import service.ItineraryService;
import service.MatchingService;
import service.TMemberService;

@Controller
@RequestMapping("/tMember/*")
public class TMemberController {

	@Autowired
	private TMemberService tMemberService;
	@Autowired
	private MatchingService matchingService;

	@Autowired
	private ItineraryService itineraryService;
	
	@RequestMapping(value = "myItinerary", method = RequestMethod.GET)
	public String myItineraryList(HttpSession session,Model model) {

	    String memberId = (String) session.getAttribute("memberId");

	    List<Itinerary> itineraryList = itineraryService.bringMyItinerary(memberId);
	    model.addAttribute("itineraryList",itineraryList);

	    return "myItinerary";
	}

	@RequestMapping(value="/showMyItinerary" ,method=RequestMethod.GET)
	public ResponseEntity<List<Itinerary>> showMyItinerary(HttpSession session,String tourName){
	    ResponseEntity<List<Itinerary>> entity = null;
	    String memberId = (String) session.getAttribute("memberId");
	    try {
	        List<Itinerary> itineraryList = itineraryService.showMyItinerary(memberId, tourName);
	        System.out.println("으악"+itineraryList);
	        entity = new ResponseEntity<List<Itinerary>>(itineraryList,HttpStatus.OK); 
	    }catch(Exception e){
	        entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	}
	
	@RequestMapping(value="/deleteMyPlan" ,method=RequestMethod.POST)
	public ResponseEntity<String> deleteMyPlan(HttpSession session,String tourName){
	      ResponseEntity<String> entity = null;
	      String memberId = (String) session.getAttribute("memberId");  
	      try {    
	         if(itineraryService.deleteMyPlan(memberId,tourName)) {
	            entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
	         }else {
	             entity = new ResponseEntity<String>("FAIL",HttpStatus.OK);
	         }
	      }catch (Exception e) {
	         e.printStackTrace();
	         entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
	      }
	            
	      return entity;
	   }
	
	// 내 정보와 함께 myInfo 페이지로 이동
	@RequestMapping(value = "/myInfo", method = RequestMethod.GET)
	public String myInfo(HttpSession session, Model model) {

		String id = (String) session.getAttribute("memberId");
		System.out.println("현재 접속 아이디 : " + id);

		if (id == null) {
			return "redirect:../log/login";

		} else {
			tMemberService.selectOneById(id);
			model.addAttribute("memberInfo", tMemberService.selectOneById(id));

			return "myInfo";
		}

	}

	// 탈퇴/myInfo DeleteBtn - 입력한 비밀번호와 내 DB정보의 비밀번호가 같은지 확인 후 탈퇴처리
	@RequestMapping(value = "/myInfoPassCheck", method = RequestMethod.POST)
	@ResponseBody
	public String myInfoPassCheck(HttpSession session, String memberId, String memberPass, String memberPassCheck,
			Model model) {

		if (tMemberService.selectOneById(memberId).getMemberPass().equals(memberPass)) {
			// 비밀번호가 일치함
			// 회원 탈퇴시 해야할 일 -> tMemberService에서 해줌

			tMemberService.deleteMember(memberId);
			session.removeAttribute("memberId");
			return "success";

		} else {
			return "fail";
		}
	}

	// 프로필 수정
	@RequestMapping(value = "updateProfile", method = RequestMethod.POST)
	@ResponseBody
	public String JoinProfileUpdate(HttpSession session, HttpServletRequest request, Model model) throws Exception {
		System.out.println("myInfo - 내 프로필 사진 수정 요청");

		String id = request.getParameter("id");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile multipartFile = multipartRequest.getFile("profile");

		String fullName = tMemberService.joinProfile(id, multipartFile);
//		System.out.println(fullName);

		if (fullName != null) {
			// 가입 step 2 완료
			return fullName;

		} else {
			return "fail";
		}

	}

	// myInfo UpdateBtn - 내 정보 수정 처리
	@RequestMapping(value = "/myInfoUpdate", method = RequestMethod.POST)
	@ResponseBody
	public String myInfoUpdate(TMember tMember, Model model) {
		System.out.println("내 정보 수정 요청");
//		System.out.println(tMember);

		if (tMemberService.modifyMember(tMember)) {
			// 성공
			return "success";
		}
		return "fail";
	}

	// 로그아웃 요청
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("로그아웃 요청");
//		System.out.println(session.getAttribute("memberId"));
		session.removeAttribute("memberId");

		return "redirect:../log/login";
	}

	// 내 동행인 리스트 (페이지) 보기
	@RequestMapping(value = "/myCompanion", method = RequestMethod.GET)
	public String myCompanionList(HttpSession session, Model model) {
		// 내 동행 신청 리스트를 가져옴
		String memberId = (String) session.getAttribute("memberId");

		Matching matching = new Matching();
		matching.setMemberId(memberId);
		matching.setMatchingType("2");

		List<Companion> companionList = matchingService.selectAllByIdAndType(matching);
//		System.out.println(companionList);
		model.addAttribute("companionList", companionList);

		return "myCompanion";
	}

	// MyPage의 나의 동행인 리스트를 보여주는 메서드
	// 타입에 따라 다른 결과를 보낸다.
	@RequestMapping(value = "/myCompanionByType", method = RequestMethod.POST)
	public ResponseEntity<List<Companion>> myCompanionByType(Matching matching) {
		System.out.println("여기 들어옴");
		ResponseEntity<List<Companion>> entity = null;

		List<Companion> companionList = matchingService.selectAllByIdAndType(matching);

		if (companionList != null) {
			entity = new ResponseEntity<List<Companion>>(companionList, HttpStatus.OK);
		} else {
			entity = new ResponseEntity<List<Companion>>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 글 삭제
	@RequestMapping(value = "/deleteMyCompanion", method = RequestMethod.GET)
	public ResponseEntity<String> deleteCompanion(Matching matching) {
		ResponseEntity<String> entity = null;
		
		if(matchingService.deleteMatchingbyIdAndSeq(matching)==1) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);

		}else {
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}