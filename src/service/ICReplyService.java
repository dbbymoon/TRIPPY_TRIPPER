package service;

import java.util.List;

import model.CReply;

public interface ICReplyService {

	//댓글 추가(대댓글 제외)
	public int insertReply(CReply cReply);
	
	//특정 게시물의 모든 댓글 조회
	public List<CReply> selectAllReply(int comapnionSeq);
	
	//댓글 삭제
	public int deleteReply(int cReplySeq);
	
}