package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CReplyDao;
import model.CReply;

@Service
public class CReplyService implements ICReplyService{
	
	@Autowired
	private CReplyDao cReplyDao;
	
	@Override
	// 댓글 추가(대댓글X)
	public int insertReply(CReply cReply) {
		int result = 0;
		//tReply에 @+memberId가 있으면 대댓글
		//없으면 그냥 댓글임
		
		if(cReply.getReplyContent().contains("@")) {
			// 대댓글이 달릴 댓글의 대댓글 수 가져오기
			int depth = cReplyDao.getReplyCount(cReply.getcReplyNum());
			cReply.setDepth(depth);
			
			if (cReplyDao.insertReplyOfReply(cReply) > 0) {
				result = 1;
			}
		}else {
			// 그냥 댓글일 경우
			cReply.setDepth(0);
			System.out.println(cReply);

			if (cReplyDao.insertReply(cReply) > 0) {
				result = 1;
			}
		}
		return result;
	}

	@Override
	// 특정 게시글의 모든 댓글 조회
	public List<CReply> selectAllReply(int companionSeq) {
		return cReplyDao.selectAllReply(companionSeq);
	}

	@Override
	// 댓글 삭제
	public int deleteReply(int cReplySeq) {
		//만약 삭제하려는 댓글의 depth가 0이면 같은 replyNum을 가진 댓글 전부 삭제
		CReply creply = cReplyDao.selectOneReply(cReplySeq);

		if(creply.getDepth() == 0) {
			return cReplyDao.deleteAllReplyforReplyNum(creply.getcReplyNum());
		}else {
			//만약 삭제하려는 댓글의 depth가 0이 아니면 선택한 댓글 하나만 삭제
			return cReplyDao.deleteReply(cReplySeq);
		}
	}
	
}
