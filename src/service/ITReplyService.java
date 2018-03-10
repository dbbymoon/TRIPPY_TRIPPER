package service;

import java.util.List;

import model.TReply;

public interface ITReplyService {

	//댓글 추가(대댓글 제외)
	public int insertReply(TReply tReply);
	
	//특정 게시물의 모든 댓글 조회
	public List<TReply> selectAllReply(int recordSeq);
	
	//댓글 삭제
	public int deleteReply(int tReplySeq);
	
}
