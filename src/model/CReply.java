package model;

public class CReply {
	private int cReplySeq;			//전체 댓글 번호
	private int cReplyNum;			//댓글 번호(대댓글 제외)
	private int depth;				//깊이 : 대댓글을 위한 변수
	private int companionSeq;		//댓글이 달리는 게시글 번호
	private String memberId;		//댓글 작성자 회원 아이디
	private String replyContent;	//댓글 내용
	private String memberProfile; 	//프로필사진
	private int secret;				//비밀댓글여부 1이면 공개 2면 비공개
	
	public int getcReplySeq() {
		return cReplySeq;
	}
	public void setcReplySeq(int cReplySeq) {
		this.cReplySeq = cReplySeq;
	}
	public int getcReplyNum() {
		return cReplyNum;
	}
	public void setcReplyNum(int cReplyNum) {
		this.cReplyNum = cReplyNum;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getCompanionSeq() {
		return companionSeq;
	}
	public void setCompanionSeq(int companionSeq) {
		this.companionSeq = companionSeq;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getSecret() {
		return secret;
	}
	public void setSecret(int secret) {
		this.secret = secret;
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
		return "CReply [cReplySeq=" + cReplySeq + ", cReplyNum=" + cReplyNum + ", depth=" + depth + ", companionSeq="
				+ companionSeq + ", memberId=" + memberId + ", secret=" + secret + ", replyContent=" + replyContent
				+ ", memberProfile=" + memberProfile + "]";
	}
	
	
}
