package member;

public interface MemberService {

	public int login(String user_id , String user_password);
	// 로그인 확인
	public int user_num(String user_id);
	// 임시 유저 고유 번호 호출
	public String user_id(int user_num);
	// 임시 유저 아이디 호출
	
}
