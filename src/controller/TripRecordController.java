package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import model.AttachFile;
import model.TMember;
import model.TripRecord;
import service.TMemberService;
import service.TripRecordService;

@Controller
@RequestMapping("/tripRecord/*")
public class TripRecordController {

	@Autowired
	private TripRecordService tripRecordService;

	@Autowired
	private TMemberService tMemberService;

	
	// 내 다이어리 리스트 요청
	@RequestMapping(value = "/myDiaryList")
	public String myDiary(HttpSession session, Model model) {

		// 현재 접속한 내 아이디
		String memberId = (String) session.getAttribute("memberId");

		// 내가 작성한 게시글의 대표사진 가져오기
		List<AttachFile> fileList = tripRecordService.selectAllThumnailImg(memberId);

		model.addAttribute("fileList", fileList);
		model.addAttribute("memberInfo", tMemberService.selectOneById(memberId));

		return "myDiaryList";
	}
	
	
	// 내 다이어리 View 요청
	@RequestMapping(value = "/myDiaryView/{recordSeq}")
	public ResponseEntity<Map<String, Object>> myDiaryContent(@PathVariable("recordSeq") int recordSeq, Model model, 
			HttpSession session) {
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			// 내가 작성한 게시글 가져오기
			TripRecord tripRecord = tripRecordService.selectOneMyRecord(recordSeq);
			List<AttachFile> fileList = tripRecordService.selectAllAttachfileByRecordSeq(recordSeq);
			TMember tmember = tMemberService.selectOneById((String) session.getAttribute("memberId"));

			map.put("fileList", fileList);
			map.put("tripRecord", tripRecord);
			map.put("memberInfo", tmember);
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	
	// 내 다이어리 수정 폼 요청
	@RequestMapping(value = "myDiaryModifyForm/{recordSeqNum}")
	public ResponseEntity<Map<String, Object>> myDiaryModifyForm(@PathVariable("recordSeqNum") int recordSeqNum, Model model) {
		System.out.println("다이어리 수정 폼 요청 : " + recordSeqNum);
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			// 내가 작성한 게시글 가져오기
			TripRecord tripRecord = tripRecordService.selectOneMyRecord(recordSeqNum);
			List<AttachFile> fileList = tripRecordService.selectAllAttachfileByRecordSeq(recordSeqNum);

			map.put("recordContent", tripRecord);
			map.put("attachFiles", fileList);
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	// 내 다이어리 수정 요청
	@RequestMapping(value = "/myDiaryModify", method = RequestMethod.GET)
	@ResponseBody
	public String myDiaryModify(TripRecord tripRecord, Model model) {

		if (tripRecordService.myDiaryModify(tripRecord)) {
			return "success";
				
		} else {
			return "fail";
		}
			
	}	


	// 내 다이어리 작성 폼 요청
	@RequestMapping(value = "/myDiaryWriteForm")
	public String myDiaryWriteForm(HttpSession session, Model model) {

		model.addAttribute("id", session.getAttribute("memberId"));

		return "myDiaryWriteForm";
	}

	// 내 다이어리 작성 요청
	@RequestMapping(value = "/myDiaryWrite")
	public String myDiaryWrite(HttpServletRequest request, Model model, TripRecord tripRecord)
			throws IllegalStateException, IOException {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; // 다중파일 업로드
		List<MultipartFile> files = multipartRequest.getFiles("file");

		if (tripRecordService.myDiaryWrite(tripRecord, files)) {
			model.addAttribute("msg", "글 작성 완료!");
			model.addAttribute("state", "success");
			model.addAttribute("url", "../tripRecord/myDiaryList");

		} else {
			model.addAttribute("msg", "글 작성 실패!");
			model.addAttribute("state", "fail");
			model.addAttribute("url", "../tripRecord/myDiaryWriteForm");
		}

		return "result";
	}
	

	// 내 다이어리 삭제 요청
	@RequestMapping(value = "/myDiaryDelete/{recordSeq}", method = RequestMethod.GET)
	@ResponseBody
	public String myDiaryDelete(@PathVariable("recordSeq") int recordSeq, HttpSession session, Model model) {

		if (tripRecordService.myDiaryDelete(recordSeq)) {
			return "success";
		}

		return "fail";
	}
	
	
	// TripRecord 게시판 리스트 요청
	   @RequestMapping(value = "/tripRecordList")
	   public String tripRecordList(HttpSession session, Model model) {
	      model.addAttribute("AllList", tripRecordService.selectAllTripRecord());
	      
	      return "tripRecordList";
	   }
	
	
	// 특정 사람의 다이어리 리스트 요청 (비공개 게시물은 안 보임)
	@RequestMapping(value = "/memberDiaryView")
	public String memberDiaryView(HttpServletRequest rq, HttpSession session, Model model) {
		String memberId = rq.getParameter("memberId");

		// 내가 작성한 게시글의 대표사진 가져오기
		List<AttachFile> fileList = tripRecordService.selectAllmemberImgByPublic(memberId);

		model.addAttribute("fileList", fileList);
		model.addAttribute("memberInfo", tMemberService.selectOneById(memberId));

		return "memberDiaryView";
	}	
	
	// 특정 사람의 정보 보기 요청
	@RequestMapping(value = "/memberInfoView/{memberId}")
	public ResponseEntity<TMember> memberInfoView (@PathVariable("memberId") String memberId, Model model) {
	    // 공개 : id, gender, name, email, birth, profile, introduction
	    // 비공개 : id, profile, introduction

	    ResponseEntity<TMember> entity = null;
	    TMember member = tMemberService.selectOneById(memberId);

	    if (member != null) {
	        TMember memberInfo = tMemberService.selectOneById(memberId);
	        entity = new ResponseEntity<TMember>(memberInfo, HttpStatus.OK);
	    }
	    return entity;
	}

}
