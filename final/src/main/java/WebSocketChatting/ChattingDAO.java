package WebSocketChatting;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("chattingdao")
public interface ChattingDAO {
	
	public int getCount_log(int buyer_num , int seller_num , int roomNumber);
	// chatting_info 테이블에서 조건에 따라 count 수 값 조회
	
	public int insertChatting_log(ChattingDTO dto);
	// chatting_info 테이블에 insert
	
	public List<ChattingDTO> getChatting_list(int seller_num , int product_num);
	// 판매자의 채팅 목록 조회를 위한 roomNumber list
	
	public int getCount_log2(int seller_num , int product_num);
	// 판매자의 채팅 목록의 갯수
	

}
