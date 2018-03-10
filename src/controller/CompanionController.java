package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import model.Companion;
import model.Matching;
import service.CompanionService;
import service.MatchingService;

@Controller
@RequestMapping("/companion")
public class CompanionController {

	@Autowired
	private CompanionService companionService;

	@Autowired
	private MatchingService matchingService;

	// 동행 구하는 게시판 목록으로 이동
	@RequestMapping(value = "")
	public String CompanionList(Model model, HttpSession session, @RequestParam(defaultValue = "0") int type,
			@RequestParam(required = false) String companionSearch1,
			@RequestParam(required = false) String companionSearch2,
			@RequestParam(required = false) String companionSearchId) {

		Map<String, Object> params = new HashMap<String, Object>();

		if (type == 1) {
			// 검색O
			if (companionSearch1.equals("")) {
				// 목적지만 검색했을 때
				params.put("destination", companionSearch2);
			} else if (companionSearch2.equals("")) {
				// 출발지만 검색했을 때
				params.put("departure", companionSearch1);
			} else {
				// 모두 검색했을 때
				params.put("departure", companionSearch1);
				params.put("destination", companionSearch2);
			}
		} else if (type == 2) {
			// Id검색을 했을 때
			params.put("memberId", companionSearchId);
		}
		
		params.put("type", type);

		model.addAttribute("companionList", companionService.getAllCompanionList(params));
		model.addAttribute("memberProfile", session.getAttribute("memberProfile"));

		return "companionList";
	}

	// 글 작성
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public ResponseEntity<String> wirteCompanion(Companion companion, Matching matching) {
		ResponseEntity<String> entity = null;

		if (companionService.insertCompanion(companion, matching) == 1) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			// 실패
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 글 수정폼에 띄울 정보를 요청
	@RequestMapping(value = "/getModify/{companionSeq}", method = RequestMethod.GET)
	public ResponseEntity<Companion> getComBoardInfo(@PathVariable("companionSeq") int companionSeq) {
		ResponseEntity<Companion> entity = null;

		try {
			Companion companion = companionService.selectCompanionByNum(companionSeq);
			entity = new ResponseEntity<Companion>(companion, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<Companion>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 글 수정
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public ResponseEntity<String> updateCompanion(Companion companion) {
		ResponseEntity<String> entity = null;
		
		if (companionService.updateCompanion(companion) == 1) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			// 실패
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 글 삭제
	@RequestMapping(value = "/delete/{companionSeq}", method = RequestMethod.GET)
	public ResponseEntity<String> deleteCompanion(@PathVariable("companionSeq") int companionSeq) {
		ResponseEntity<String> entity = null;

		try {
			matchingService.deleteMatching(companionSeq);
			companionService.deleteCompanion(companionSeq);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 동행(goWith)버튼을 눌렀을 때 동행 목록(matching)에 추가
	@RequestMapping(value = "/goWith", method = RequestMethod.GET)
	public ResponseEntity<String> goWith(Matching matching) {
		ResponseEntity<String> entity = null;

		if (matchingService.insertMatching(matching) == 1) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);

		} else {
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 글 번호에 해당하는 동행인 리스트 요청하는 메서드
	@RequestMapping(value = "/getGowithList/{companionSeq}", method = RequestMethod.POST)
	public ResponseEntity<List<Map<String, Object>>> getGowithList(@PathVariable("companionSeq") int companionSeq) {
		ResponseEntity<List<Map<String, Object>>> entity = null;

		try {
			List<Map<String, Object>> tMemberMatchingList = companionService.getGowithList(companionSeq);
			entity = new ResponseEntity<List<Map<String, Object>>>(tMemberMatchingList, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<List<Map<String, Object>>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 동행인 리스트에서 동행 신청인의 매칭 타입을 바꾸는 메서드
	@RequestMapping(value = "/changeMatchingType", method = RequestMethod.GET)
	public ResponseEntity<String> changeMatchingType(Matching matching) {
		ResponseEntity<String> entity = null;

		if (matchingService.updateMatching(matching) == 1) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	
}
