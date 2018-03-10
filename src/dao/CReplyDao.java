package dao;

import java.util.List;

import model.CReply;

public interface CReplyDao {

	//기본 CRUD
	public int insertReply(CReply cReply);
	public int updateReply(CReply cReply);
	public int deleteReply(int cReplySeq);
	public CReply selectOneReply(int cReplySeq);
	
	//추가메서드 : 메서드 기능 주석 달아주세요
	public List<CReply> selectAllReply(int companionSeq);
	//댓글 삭제시 대댓글이 달려있을 때 삭제하지 않고 content와 id값만 변경 
	public int updateReplyoWithRepOfRep(CReply cReply);
	//특정 댓글의 대댓글 수 조회
	public int getReplyCount(int cReplyNum);
	//대댓글 추가
	public int insertReplyOfReply(CReply cReply);
	//같은 cReplyNum을 가진 모든 댓글 삭제
	public int deleteAllReplyforReplyNum(int cReplyNum);
	//여행 게시글이 삭제됬을 떄 모든 댓글 삭제
	public int deleteReplyByRecordSeq(int companionSeq);
	//비밀댓글 여부 바꾸기
	public int updateReplyForSecret(CReply cReply);
	//프로필사진이 수정되면 댓글의 프로필 사진도 수정되어야 함
	public int updateReplyForProfile(CReply cReply);
}
