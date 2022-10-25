package upload;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("uploaddao")
public interface UploadDAO {

	int insertFile(UploadDTO dto);
}
