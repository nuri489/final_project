package member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import product.ProductDTO;

@Mapper
@Repository("memberdao")
public interface MemberDAO {
	
	public int checkLogin(String user_id , String user_password);
	// 유저 로그인
	public int getUser_num(String user_id);
	// 임시 유저 고유 번호 호출
	public String getUser_id(int user_num);
	// 임시 유저 아이디 호출
	
	//회원정보
	public List<MemberDTO> oneMember(String id);
	//회원가입
	public int insertMember(MemberDTO dto);
	//[승희] 판매글모아보기
	public List<ProductDTO> productList(int user_num);
	/**
	 * 회원 마이페이지 정보 가져오기
	 * @param user_num 회원 식별자
	 */
	public MemberDTO selectMyPage(int user_num);
	
	
}
