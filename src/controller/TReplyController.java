package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import model.TReply;
import service.TReplyService;

@Controller
@RequestMapping("/tReply/*")
public class TReplyController {

	@Autowired
	private TReplyService tReplyService;
	
	@RequestMapping(value="/addReply", method=RequestMethod.POST)
	public ResponseEntity<String> addReply(TReply reply) {
		ResponseEntity<String> entity = null;
		
		if (tReplyService.insertReply(reply) == 1) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} else {
			// 실패
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/getReplyList", method=RequestMethod.POST)
	public ResponseEntity<List<TReply>> getReplyList(TReply reply){
		ResponseEntity<List<TReply>> entity = null;
		List<TReply> tRList = tReplyService.selectAllReply(reply.getRecordSeq());

		if(tRList != null) {
			entity = new ResponseEntity<List<TReply>>(tRList, HttpStatus.OK);
		}else {
			entity = new ResponseEntity<List<TReply>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/deleteReply/{tReplySeq}", method=RequestMethod.GET)
	public ResponseEntity<String> deleteReply(@PathVariable("tReplySeq") int tReplySeq){
		ResponseEntity<String> entity = null;

		if(tReplyService.deleteReply(tReplySeq) > 0) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
