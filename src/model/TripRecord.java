package model;

import java.util.Date;

public class TripRecord {
	private int recordSeq; // RECORD_SEQ
	private String memberId; // 다이어리 및 후기 글 작성 회원 아이디
	private String recordContent; // 다이어리 및 후기 글 내용
	private String recordSpot; // 다이어리 및 후기 여행지
	private String recordSecret; // 공개 여부 : 공개/비공개 - 공개 시 내 다이어리와 후기 커뮤니티에 게시물이 올라가고, 비공개 시 내 다이어리에만 게시물이 올라감
	private Date recordDate; // 여행 날짜
	private Date recordWriteDate; // 글 게시 날짜
	private int readCount; // 조회수

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

	public String getRecordContent() {
		return recordContent;
	}

	public void setRecordContent(String recordContent) {
		this.recordContent = recordContent;
	}

	public String getRecordSpot() {
		return recordSpot;
	}

	public void setRecordSpot(String recordSpot) {
		this.recordSpot = recordSpot;
	}

	public String getRecordSecret() {
		return recordSecret;
	}

	public void setRecordSecret(String recordSecret) {
		this.recordSecret = recordSecret;
	}

	public Date getRecordDate() {
		return recordDate;
	}

	public void setRecordDate(Date recordDate) {
		this.recordDate = recordDate;
	}

	public Date getRecordWriteDate() {
		return recordWriteDate;
	}

	public void setRecordWriteDate(Date recordWriteDate) {
		this.recordWriteDate = recordWriteDate;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	@Override
	public String toString() {
		return "TripRecord [recordSeq=" + recordSeq + ", memberId=" + memberId
				+ ", recordContent=" + recordContent + ", recordSpot=" + recordSpot + ", recordSecret=" + recordSecret
				+ ", recordDate=" + recordDate + ", recordWriteDate=" + recordWriteDate + ", readCount=" + readCount
				+ "]";
	}

}
