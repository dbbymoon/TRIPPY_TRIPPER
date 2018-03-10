package model;

import java.util.Date;

public class TReply {
	private int tReplySeq;			//전체 댓글 번호
	private int replyNum;			//댓글 번호(대댓글 제외)
	private int depth;				//깊이 : 대댓글을 위한 변수
	private int recordSeq;			//댓글이 달리는 게시글 번호
	private String memberId;		//댓글 작성자 회원 아이디
	private Date replyDate;			//댓글 작성 날짜
	private String replyContent;	//댓글 내용
	private String memberProfile; 	//프로필사진
	public int gettReplySeq() {
		return tReplySeq;
	}
	public void settReplySeq(int tReplySeq) {
		this.tReplySeq = tReplySeq;
	}
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getRecordSeq() {
		return recordSeq;
	}
	public void setRecordSeq(int recordSeq) {
		this.recordSeq = recordSeq;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public Date getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getMemberProfile() {
		return memberProfile;
	}
	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}
	@Override
	public String toString() {
		return "TReply [tReplySeq=" + tReplySeq + ", replyNum=" + replyNum + ", depth=" + depth + ", recordSeq="
				+ recordSeq + ", memberId=" + memberId + ", replyDate=" + replyDate + ", replyContent=" + replyContent
				+ ", memberProfile=" + memberProfile + "]";
	}

}
