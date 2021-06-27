package edu.coldrain.mapper;

import java.util.List;

import edu.coldrain.domain.BookVO;

public interface BookMapper {

	// 책 추가하기
	public int insert(BookVO bookVO);
	
	// 특정 책 조회하기
	public BookVO read(Long bookId);
	
	// 특정 책 수정하기
	public int update(BookVO bookVO);
	
	// 특정 책 삭제하기
	public int delete(Long bookId);
	
	// 모든 책의 목록 조회하기
	public List<BookVO> readList();

}
