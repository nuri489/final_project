package WebSocketChatting;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.demo.NaverInform;

import product.ProductDTO;

@Service("chattingservice")
public class ChattingService_Impl implements ChattingService {

	@Autowired
	ChattingDAO chatdao;

	@Override
	public int countlog(int buyer_num,  int seller_num, int roomNumber) {
		return chatdao.getCount_log(buyer_num, seller_num, roomNumber);
	}
	
	@Override
	public int chattinglog(ChattingDTO dto) {
		return chatdao.insertChatting_log(dto);
	}

	@Override
	public List<ChattingDTO> chattinglist(int seller_num , int product_num) {
		return chatdao.getChatting_list(seller_num , product_num);
	}

	@Override
	public int countlog2(int seller_num, int product_num) {
		return chatdao.getCount_log2(seller_num, product_num);
	}

	@Override
	public void createFile(int roomNumber) throws IOException {
		
		String fileName = roomNumber+".json";
		String pathName = NaverInform.path + fileName;
		
		File txtFile = new File(pathName);
		txtFile.createNewFile();
		
		FileWriter file = new FileWriter(txtFile , true);
		file.write("[{\"msg\":\"안전거래 수칙을 지켜주세요\",\"roomNumber\":"+roomNumber+",\"type\":\"message\",\"sessionUser_num\":\"0\",\"userName\":\"SYSTEM\"}]");
		file.flush();
		file.close();
		
	}

	
	

	
}
