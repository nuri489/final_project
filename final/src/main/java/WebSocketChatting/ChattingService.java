package WebSocketChatting;

import java.io.IOException;
import java.util.List;

public interface ChattingService {

	
	public int countlog(int buyer_num , int seller_num , int roomNumber);
	public int chattinglog(ChattingDTO dto);
	public List<ChattingDTO> chattinglist(int seller_num , int product_num);
	public int countlog2(int seller_num , int product_num);
	
	public void createFile(int roomNumber) throws IOException;
	
}
