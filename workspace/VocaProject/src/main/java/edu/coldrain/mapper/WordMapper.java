package edu.coldrain.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import edu.coldrain.domain.Criteria;
import edu.coldrain.domain.WordVO;

public interface WordMapper {

	// 특정 카테고리에 단어 추가하기
	public int insert(WordVO wordVO);
	
	// 특정 단어 조회하기
	public WordVO read(Long wordId);
	
	// 특정 단어 수정하기
	public int update(WordVO wordVO);
	
	// 특정 단어 삭제하기
	public int delete(Long wordId);
	
	// 모든 단어의 목록 조회하기
	public List<WordVO> readList();
	
	// 특정 카테고리의 모든 단어 목록 조회하기
	public List<WordVO> readListByCategoryId(Long categoryId);
	
	// 특정 카테고리의 모든 단어 목록 조회하기 ( 1/4/7/14 학습법 적용 )
	public List<WordVO> readListByRownum(@Param("rownum") Long rownum, @Param("bookId") Long bookId);
	
	// 카테고리로 ROWNUM 조회
	public Long readRownumByCategoryId(@Param("categoryId") Long categoryId, @Param("bookId") Long bookId);
	
	// 특정 페이지의 해당하는 특정 카테고리에 소속된 모든 단어 목록 조회하기 ( 페이징 처리 )
	public List<WordVO> readListWithPaging(@Param("categoryId") Long categoryId, @Param("criteria") Criteria criteria);

	// 특정 카테고리에 소속된 모든 레코드 개수 조회하기
	public int readTotalCount(Long categoryId);
}	
