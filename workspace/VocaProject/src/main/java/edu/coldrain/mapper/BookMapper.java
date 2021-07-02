package edu.coldrain.mapper;

import java.util.List;

import edu.coldrain.domain.BookVO;
import edu.coldrain.domain.Criteria;

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
	
	// 특정 페이지의 해당하는 책의 목록 조회하기 ( 페이징 처리 )
	public List<BookVO> readListWithPaging(Criteria criteria);
	
	// 책 레코드의 총 개수 조회
	public int readTotalCount();

}
