package member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import likeinfo.LikeInfoDTO;
import product.ProductDTO;

@Service("memberservice")
public class MemberService_Impl implements MemberService {

	@Autowired
	MemberDAO dao;
	
	
	@Override
	public int login(String user_id, String user_password) {
		return dao.checkLogin(user_id , user_password);
	}
	
	@Override
	public int user_num(String user_id) {
		return dao.getUser_num(user_id);
	}
	// 임시 유저 고유 번호 확인

	@Override
	public String user_id(int user_num) {
		return dao.getUser_id(user_num);
	}
	// 임시 유저 아이디 호출

	//회원가입
	@Override
	public List<MemberDTO> onemember(String user_id){
		return dao.oneMember(user_id);
	}
	
	@Override
	public int registerMember(MemberDTO dto) {
		//dto.getUser_num() 조회해본다.
		List<MemberDTO> list = dao.oneMember(dto.getUser_id());
		//조회결과 있는지 확인한다
		if(list == null || list.size() == 0) {
			return dao.insertMember(dto);
		}
		else {
			return 0;
		}
	}
	
	//[승희] 판매글모아보기
	@Override
	public List<ProductDTO> getProductList(int user_num){
		return dao.productList(user_num);
	}
	/**
	 * 회원 마이페이지
	 */
	@Override
	public MemberDTO getUser(int user_num) {
		return dao.selectMyPage(user_num);
	}

	@Override
	public List<LikeInfoDTO> getWishList(int user_num) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
