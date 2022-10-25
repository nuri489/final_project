package member;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import likeinfo.LikeInfoDAO;
import likeinfo.LikeInfoDTO;
import product.ProductDTO;

@Service("memberservice")
public class MemberService_Impl implements MemberService {

	@Autowired
	MemberDAO dao;
	
	@Autowired
	LikeInfoDAO likeInfoDAO;
	
	@Autowired
	JavaMailSender sender;
	
	
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

	
	@Override
	public MemberDTO getUser(int user_num) {
		return dao.selectMyPage(user_num);
	}
	
	@Override
	public List<LikeInfoDTO> getWishList(int user_num) {
		return likeInfoDAO.selectMemberWishList(user_num);
	}
	
	@Override
	public int countmyid(String user_email) {
		return dao.countMy_id(user_email);
	}
	@Override
	public String getmyid(String user_email) {
		return dao.getMy_id(user_email);
	}
	
	@Override
	public MimeMessage createMessage(String email , String user_id) throws MessagingException, UnsupportedEncodingException {
		
		MimeMessage message = sender.createMimeMessage();

		message.addRecipients(RecipientType.TO, email);// 보내는 대상
		message.setSubject("GoodJob 회원가입 이메일 인증");// 제목

		String msgg = "";
		msgg += "중고마켓 아이디 찾기<br>";
		msgg += "회원님의 아이디 : "+ user_id;
		msgg += "<br>아이디 찾기를 하신게 본인이 아니라면 중고마켓의 비밀번호를 변경하시길 바랍니다";
		message.setText(msgg, "utf-8", "html");// 내용, charset 타입, subtype
		// 보내는 사람의 이메일 주소, 보내는 사람 이름
		message.setFrom(new InternetAddress("nuri489@naver.com", "중고마켓"));// 보내는 사람
		
		sender.send(message);

		return message;
	}

	@Override
	public String createKey() {
		StringBuffer key = new StringBuffer();
		Random rnd = new Random();

		for (int i = 0; i < 8; i++) { // 인증코드 8자리
			int index = rnd.nextInt(3); // 0~2 까지 랜덤, rnd 값에 따라서 아래 switch 문이 실행됨

			switch (index) {
			case 0:
				key.append((char) ((int) (rnd.nextInt(26)) + 97));
				// a~z (ex. 1+97=98 => (char)98 = 'b')
				break;
			case 1:
				key.append((char) ((int) (rnd.nextInt(26)) + 65));
				// A~Z
				break;
			case 2:
				key.append((rnd.nextInt(10)));
				// 0~9
				break;
			}
		}

		return key.toString();
	}
}
