package dao;

import java.util.List;

import model.TReply;

public interface TReplyDao {

	//기본 CRUD
	public int insertReply(TReply tReply);
	public int updateReply(TReply tReply);
	public int deleteReply(int tReplySeq);
	public TReply selectOneReply(int tReplySeq);
	
	//추가메서드 : 메서드 기능 주석 달아주세요
	public List<TReply> selectAllReply(int recordSeq);
	//댓글 삭제시 대댓글이 달려있을 때 삭제하지 않고 content와 id값만 변경 
	public int updateReplyoWithRepOfRep(TReply tReply);
	//특정 댓글의 대댓글 수 조회
	public int getReplyCount(int replyNum);
	//대댓글 추가
	public int insertReplyOfReply(TReply tReply);
	//같은 replyNum을 가진 모든 댓글 삭제
	public int deleteAllReplyforReplyNum(int tReplyNum);
	//여행 게시글이 삭제됬을 떄 모든 댓글 삭제
	public int deleteReplyByRecordSeq(int recordSeq);
	//프로필사진이 수정되면 댓글의 프로필 사진도 수정되어야 함
	public int updateReplyForProfile(TReply tReply);
}
