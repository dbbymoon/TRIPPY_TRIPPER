package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import model.CReply;
import service.CReplyService;


@Controller
@RequestMapping("/cReply/*")
public class CReplyController {

	@Autowired
	private CReplyService cReplyService;
	
	@RequestMapping(value="/addReply", method=RequestMethod.POST)
	public ResponseEntity<String> addReply(CReply reply) {
		System.out.println("댓글 등록하러 와쩌염!");
		ResponseEntity<String> entity = null;
		
		if (cReplyService.insertReply(reply) == 1) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			// 실패
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/getReplyList", method=RequestMethod.POST)
	public ResponseEntity<List<CReply>> getReplyList(CReply reply){
		ResponseEntity<List<CReply>> entity = null;
		List<CReply> cRList = cReplyService.selectAllReply(reply.getCompanionSeq());
		System.out.println("controller에욤  "+cRList);
		if(cRList != null) {
			entity = new ResponseEntity<List<CReply>>(cRList, HttpStatus.OK);
		}else {
			entity = new ResponseEntity<List<CReply>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/deleteReply/{cReplySeq}", method=RequestMethod.GET)
	public ResponseEntity<String> deleteReply(@PathVariable("cReplySeq") int cReplySeq){
		ResponseEntity<String> entity = null;

		if(cReplyService.deleteReply(cReplySeq) > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}