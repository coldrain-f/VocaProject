package edu.coldrain.service;

import java.util.List;

import edu.coldrain.domain.BookVO;
import edu.coldrain.domain.Criteria;

public interface BookService {

	// 책 추가하기
	public boolean register(BookVO bookVO);
    
	// 특정 책 조회하기
	public BookVO get(Long bookId);
	
	// 특정 책 수정하기
	public boolean modify(BookVO bookVO);
	
	// 특정 책 삭제하기
	public boolean remove(Long bookId);
	
	// 모든 책의 목록 조회하기
	public List<BookVO> getList();
	
	// 특정 페이지의 해당하는 책의 목록 조회하기 ( 페이징 처리 ) 
	public List<BookVO> getListWithPaging(Criteria criteria);
	
	// 레코드 총 개수 조회하기
	public int getTotalCount();
}
