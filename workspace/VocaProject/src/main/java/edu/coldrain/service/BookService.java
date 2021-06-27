package edu.coldrain.service;

import java.util.List;

import edu.coldrain.domain.BookVO;

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
}
