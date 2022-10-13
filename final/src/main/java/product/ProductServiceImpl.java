package product;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("productservice")
public class ProductServiceImpl implements ProductService{

	@Autowired
	@Qualifier("productdao")
	ProductDAO productDAO;
	
	@Override
	public List<ProductDetailDTO> getpdtDetailTags(String keyword) {
		return productDAO.getpdtDetailTags(keyword);
	}

	@Override
	public int insertSales(ProductDTO dto) {
		return productDAO.insertSales(dto);
	}

	@Override
	public int getLastInsertNum() {
		return productDAO.getLastInsertNum();
	}

	@Override
	public List<String> getforSale(HashMap<String, String> map) {
		return productDAO.getforSale(map);
	}

	@Override
	public List<ProductDTO> getProducts(ProductDTO dto) {
		return productDAO.getProducts(dto);
	}

	@Override
	public int likeProduct(ProductDTO dto) {
		return productDAO.likeProduct(dto);
	}
	
	@Override
	public int unlikeProduct(ProductDTO dto) {
		return productDAO.unlikeProduct(dto);
	}

	@Override
	public List<Integer> getLikeProduct(int user_num) {
		return productDAO.getLikeProduct(user_num);
	}

	@Override
	public List<ProductDTO> getBuyinglist(int buyer_num) {
		return productDAO.getBuying_list(buyer_num);
	}

	@Override
	public List<ProductDTO> getthumbnail(int product_num) {
		return productDAO.getThumbnail(product_num);

	public List<ProductDTO> getAllProducts() {
		return productDAO.getAllProducts();
	}

	@Override
	public List<ProductDTO> getProductsIdol(int idol_num) {
		return productDAO.getProductsIdol(idol_num);
	}
	
	
	
	
	
	
//	@Override
//	public List<HashMap<Integer, String>> getpdtDetailTags(String keyword) {
//		return productDAO.getpdtDetailTags(keyword);
//	}

	
}
