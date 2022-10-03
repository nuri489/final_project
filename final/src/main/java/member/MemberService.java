package member;

import java.util.List;

public interface MemberService {

	public int login(String user_id , String user_password);
	// 로그인 확인
	public int user_num(String user_id);
	// 임시 유저 고유 번호 호출
	public String user_id(int user_num);
	// 임시 유저 아이디 호출
	
	//회원정보
	public List<MemberDTO> onemember(String user_id);
	//회원가입
	public int registerMember(MemberDTO dto);
	
}
