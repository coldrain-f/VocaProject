package edu.coldrain.service;

import java.util.List;

import edu.coldrain.domain.CategoryVO;
import edu.coldrain.domain.Criteria;

public interface CategoryService {

	// 카테고리 추가하기
	public boolean register(CategoryVO categoryVO);
    
	// 특정 카테고리 조회하기
	public CategoryVO get(Long categoryId);
	
	// 특정 카테고리 수정하기
	public boolean modify(CategoryVO categoryVO);
	
	// 특정 카테고리 삭제하기
	public boolean remove(Long categoryId);
	
	// 모든 카테고리의 목록 조회하기
	public List<CategoryVO> getList();
		
	// 특정 책에 소속된 모든 카테고리의 목록 조회
	public List<CategoryVO> getListByBookId(Long bookId);
	
	// 특정 페이지의 해당하는 특정 책에 소속된 모든 카테고리 목록 조회하기 ( 페이징 처리 )
	public List<CategoryVO> getListWithPaging(Long bookId, Criteria criteria);
	
	// 특정 책에 소속된 모든 레코드 개수 조회하기
	public int getTotalCount(Long bookId);
}
