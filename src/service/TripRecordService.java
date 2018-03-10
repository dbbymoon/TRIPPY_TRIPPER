package service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import dao.AttachFileDao;
import dao.TMemberDao;
import dao.TReplyDao;
import dao.TripRecordDao;
import model.AttachFile;
import model.TMember;
import model.TripRecord;

@Service
public class TripRecordService implements ITripRecordService {

	@Autowired
	private TripRecordDao tripRecordDao;

	@Autowired
	private AttachFileDao attachFileDao;

	@Autowired
	private TMemberDao tMemberDao;
	
	@Autowired
	private TReplyDao tReplyDao;
	
	// 파일 업로드 패스
	// private static final String UPLOAD_PATH =
	// "C:\\Users\\hb2007\\user\\hb2007\\springFramwork\\TRIPPY_TRIPPER\\WebContent\\diaryImg\\";
	private static final String UPLOAD_PATH = "C:\\Users\\hb2008\\apache-tomcat-8.5.23\\webapps\\TRIPPY_TRIPPER\\diaryImg";

	// 실제 파일을 받아와서 저장, 업로드 후 파일명 반환하는 메서드 작성 : uploadFile()
	private String uploadFile(String fileName, byte[] fileData) throws Exception {

		// 읽어온 파일을 이용해서 파일을 하나 생성 : new File(저장경로, 파일이름);
		// 파일 이름이 중복되면 안됨 : UUID 붙여서 저장
		UUID uid = UUID.randomUUID();
		String fullName = uid.toString() + "_" + fileName;
		File target = new File(UPLOAD_PATH, fullName);

		FileCopyUtils.copy(fileData, target);

		return fullName;
	}

	// 다이어리 글 작성
	@Override
	public boolean myDiaryWrite(TripRecord tripRecord, List<MultipartFile> files) {

		try {
			// 게시글 먼저 작성 후 게시글 번호 받아옴
			tripRecordDao.insertTripRecord(tripRecord);
			int recordSeq = tripRecord.getRecordSeq();

			// 파일 리스트의 사이즈만큼 반복하면서 수행
			for (int i = 0; i < files.size(); i++) {

				// 입력 받은 사진이 없으면 추가 X
				if (files.get(i).getBytes().length != 0) {

					String originalFileName = uploadFile(files.get(i).getOriginalFilename(), files.get(i).getBytes());
					
					int index = originalFileName.lastIndexOf(".");
					String fileName = originalFileName.substring(0, index);
					String fileExt = originalFileName.substring(index + 1);

					File file = new File(UPLOAD_PATH + originalFileName);
					files.get(i).transferTo(file);

					Map<String, Object> params = new HashMap<String, Object>();
					params.put("recordSeq", recordSeq);

					imageResizing(file.getAbsolutePath(), originalFileName, fileExt, params);
				}
			}
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 내가 작성한 게시글 파일 이름 전부 받아오기
	@Override
	public List<AttachFile> selectAllMyAttachFileName(String memberId) {
		return attachFileDao.selectAllMyAttachFiles(memberId);
	}

	// 업로드 할 이미지 사이즈 가공하기
	@Override
	public void imageResizing(String filePath, String fullName, String fileExt, Map<String, Object> params) {

		try {
			// 원하는 이미지 크기
			int dw = 500, dh = 500;

			// 저장된 원본파일로부터 BufferedImage 객체 생성 후 원본 사이즈 구하기
			BufferedImage originImg = ImageIO.read(new File(filePath));
			int ow = originImg.getWidth();
			int oh = originImg.getHeight();

			// 원본 너비를 기준으로 하여 원하는 비율로 높이를 계산
			int nw = ow;
			int nh = (ow * dh) / dw;

			// 계산된 높이가 원본보다 높다면 crop이 안되므로, 원본 높이를 기준으로 썸네일의 비율로 너비를 계산
			if (nh > oh) {
				nw = (oh * dw) / dh;
				nh = oh;
			}

			// 계산된 크기로 원본이미지를 가운데에서 crop
			BufferedImage cropImg = Scalr.crop(originImg, (ow - nw) / 2, (oh - nh) / 2, nw, nh);

			// crop된 이미지로 이미지 생성
			BufferedImage destImg = Scalr.resize(cropImg, dw, dh);

			String newImg = "my_" + fullName;
			File myFile = new File(UPLOAD_PATH, newImg);
			ImageIO.write(destImg, fileExt.toUpperCase(), myFile);

			params.put("fileName", myFile.getName());
			attachFileDao.insertAttachFile(params);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 내가 작성한 게시글 번호로 가져오기
	@Override
	public TripRecord selectOneMyRecord(int recordSeq) {
		return tripRecordDao.selectOneTripRecord(recordSeq);
	}

	// 내가 작성한 게시글 전부 가져오기
	@Override
	public List<TripRecord> selectAllMyRecordList(String memberId) {
		return tripRecordDao.selectAllByMemberId(memberId);
	}

	// 내가 작성한 게시글의 사진 가져오기
	@Override
	public List<AttachFile> selectAllAttachfileByRecordSeq(int recordSeq) {
		return attachFileDao.selectAllAttachFiles(recordSeq);
	}

	// 다이어리 삭제
	@Override
	public boolean myDiaryDelete(int recordSeq) {

		// 게시글 번호로 파일 번호 얻어오기
		List<AttachFile> fileList = attachFileDao.selectAttachfileNum(recordSeq);

		if (fileList != null) {
			// 파일 번호만큼 반복하면서 파일 삭제
			for (int i = 0; i < fileList.size(); i++) {
				attachFileDao.deleteAttachFile(fileList.get(i).getFileNum());
			}
			
			//게시글을 삭제하기 전에 댓글도 삭제	
			tReplyDao.deleteReplyByRecordSeq(recordSeq);
			
			if (tripRecordDao.deleteTripRecord(recordSeq) > 0) {
				// 게시글과 사진 모두 삭제 완료
				return true;
			}
		}
		return false;
	}

	// 다이어리 수정
	@Override
	public boolean myDiaryModify(TripRecord tripRecord) {
		if (tripRecordDao.updateTripRecord(tripRecord) > 0) {
			return true;
		}

		return false;
	}

	// 내가 작성한 게시글 중 대표사진 가져오기
	@Override
	public List<AttachFile> selectAllThumnailImg(String memberId) {

		// 내가 가지고있는 TripRecordSeq List
		List<Integer> recordSeqList = tripRecordDao.selectAllRecordSeq(memberId);

		// 값을 넘길 List
		List<AttachFile> fileList = new ArrayList<AttachFile>();

		for (int i = 0; i < recordSeqList.size(); i++) {
			fileList.add(attachFileDao.selectAllAttachFiles(recordSeqList.get(i)).get(0));
		}

		return fileList;
	}

	// 게시글 중 Secret이 공개인 사진만 대표사진 가져오기
	@Override
	public List<AttachFile> selectAllmemberImgByPublic(String memberId) {

		// 내가 가지고 있는 TripRecordSeq List by Public
		List<Integer> recordSeqList = tripRecordDao.selectAllRecordSeqByPublic(memberId);

		// 값을 넘길 List
		List<AttachFile> fileList = new ArrayList<AttachFile>();

		for (int i = 0; i < recordSeqList.size(); i++) {
			fileList.add(attachFileDao.selectAllAttachFiles(recordSeqList.get(i)).get(0));
		}
		return fileList;
	}

	@Override
	// 모든 게시물 들고오기
	public List<Map<String, Object>> selectAllTripRecord() {
		List<Map<String, Object>> AllList = new ArrayList<Map<String, Object>>();
		List<TripRecord> recordSeqList = tripRecordDao.selectAllTripRecord();
		List<TMember> tMemberList = tMemberDao.selectAllMember();
		int i = 0;
		
		for (TripRecord t : recordSeqList) {
			
			if (t.getRecordSecret().equals("public")) {
				Map<String, Object> map = new HashMap<String, Object>();
				// 게시글 번호 넣음
				map.put("recordSeq", t.getRecordSeq());

				for (TMember m : tMemberList) {
					if (t.getMemberId().equals(m.getMemberId())) {
						// 프로필 사진 넣음
						map.put("memberProfile", m.getMemberProfile());
						// 아이디 넣음
						map.put("memberId", m.getMemberId());
					}
				}
				map.put("diaryImg", attachFileDao.selectAllAttachFiles(t.getRecordSeq()).get(0));

				// 내용넣음
				map.put("content", t.getRecordContent());
				AllList.add(map);
				i++;
			}
		}

		return AllList;
	}

}
