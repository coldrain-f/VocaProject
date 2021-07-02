package edu.coldrain.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import edu.coldrain.domain.CategoryVO;
import edu.coldrain.domain.Criteria;

public interface CategoryMapper {

	// 특정 책에 카테고리 추가하기
	public int insert(CategoryVO categoryVO);
	
	// 특정 카테고리 조회하기
	public CategoryVO read(Long categoryId);
	
	// 특정 카테고리 수정하기
	public int update(CategoryVO categoryVO);
	
	// 특정 카테고리 삭제하기
	public int delete(Long categoryId);
	
	// 모든 카테고리의 목록 조회하기
	public List<CategoryVO> readList();
	
	// 특정 책에 소속된 모든 카테고리의 목록 조회하기
	public List<CategoryVO> readListByBookId(Long bookId);
	
	// 특정 페이지의 해당하는 특정 책에 소속된 모든 카테고리 목록 조회하기 ( 페이징 처리 )
	public List<CategoryVO> readListWithPaging(@Param("bookId") Long bookId, @Param("criteria") Criteria criteria);

	// 특정 책에 소속된 모든 레코드 개수 조회하기
	public int readTotalCount(Long bookId);
	
}
