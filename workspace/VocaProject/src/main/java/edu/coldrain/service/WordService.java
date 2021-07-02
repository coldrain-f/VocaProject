package edu.coldrain.service;

import java.util.List;

import edu.coldrain.domain.Criteria;
import edu.coldrain.domain.WordVO;

public interface WordService {

	// 특정 카테고리에 단어 추가하기
	public boolean register(WordVO wordVO);
	
	// 특정 단어 조회하기 
	public WordVO get(Long wordId);
	
	// 특정 단어 수정하기
	public boolean modify(WordVO wordVO);
	
	// 특정 단어 삭제하기
	public boolean remove(Long wordId);
	
	// 모든 단어의 목록 조회하기
	public List<WordVO> getList();
	
	// 특정 카테고리의 모든 단어 목록 조회하기
	public List<WordVO> getListByCategoryId(Long categoryId);
	
	// 특정 페이지의 해당하는 특정 카테고리에 소속된 모든 단어 목록 조회하기 ( 페이징 처리 )
	public List<WordVO> getListWithPaging(Long categoryId, Criteria criteria);
		
	// 특정 카테고리에 소속된 모든 레코드 개수 조회하기
	public int getTotalCount(Long categoryId);
}
