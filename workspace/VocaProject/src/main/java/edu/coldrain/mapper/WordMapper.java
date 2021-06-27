package edu.coldrain.mapper;

import java.util.List;

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
}
