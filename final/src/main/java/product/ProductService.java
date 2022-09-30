package product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ProductService {
	
	List<ProductDetailDTO> getpdtDetailTags(String keyword);
	int insertSales(ProductDTO dto);
	int getLastInsertNum();
	List<String> getforSale(HashMap<String, String> map);
}
