package product;

import java.util.HashMap;
import java.util.List;

public interface ProductService {
	
	List<ProductDetailDTO> getpdtDetailTags(String keyword);
	int insertSales(ProductDTO dto);
	int getLastInsertNum();
}
