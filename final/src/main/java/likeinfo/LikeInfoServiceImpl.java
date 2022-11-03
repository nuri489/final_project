package likeinfo;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("likeinfoservice")
public class LikeInfoServiceImpl implements LikeInfoService {
	
	@Autowired
	LikeInfoDAO dao;
	
	// 찜 목록
	@Override
	public List<LikeInfoDTO> getWishList(int user_num) {
		return dao.selectMemberWishList(user_num);
	}
	/*public int deleteLikeInfo(int likeinfoId) {
		return likeinfoMapper.deletelikeinfo(likeinfoId);
	}*/
		
	//
}
