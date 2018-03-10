package model;

import java.util.Date;

public class AttachFile {
	private int fileNum;	//ATTACHFILE_SEQ
	private int recordSeq;	//게시글과 파일의 외래키
	private String fileName;	//파일명
	private Date fileDate;		//파일 업로드 날짜

	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}

	public int getRecordSeq() {
		return recordSeq;
	}

	public void setRecordSeq(int recordSeq) {
		this.recordSeq = recordSeq;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Date getFileDate() {
		return fileDate;
	}

	public void setFileDate(Date fileDate) {
		this.fileDate = fileDate;
	}

	@Override
	public String toString() {
		return "AttachFile [fileNum=" + fileNum + ", recordSeq=" + recordSeq + ", fileName=" + fileName + ", fileDate="
				+ fileDate + "]";
	}

}
