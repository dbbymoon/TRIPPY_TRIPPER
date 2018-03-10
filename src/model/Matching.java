package model;

public class Matching {
	private int companionSeq;	//동행 글 번호
	private String memberId;	//회원 아이디
	private String matchingType;	//매칭 여부 : 매칭/대기

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

	public String getMatchingType() {
		return matchingType;
	}

	public void setMatchingType(String matchingType) {
		this.matchingType = matchingType;
	}

	@Override
	public String toString() {
		return "Matching [companionSeq=" + companionSeq + ", memberId=" + memberId + ", matchingType=" + matchingType
				+ "]";
	}

}
