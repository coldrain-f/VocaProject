package edu.coldrain.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.coldrain.domain.CategoryVO;
import edu.coldrain.domain.Criteria;
import edu.coldrain.domain.WordVO;
import edu.coldrain.mapper.WordMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WordServiceImpl implements WordService {

	private final WordMapper mapper;
	
	@Override
	public boolean register(WordVO wordVO) {
		return ( mapper.insert(wordVO) == 1 );
	}

	@Override
	public WordVO get(Long wordId) {
		return mapper.read(wordId);
	}

	@Override
	public boolean modify(WordVO wordVO) {
		return ( mapper.update(wordVO) == 1 );
	}

	@Override
	public boolean remove(Long wordId) {
		return ( mapper.delete(wordId) == 1 );
	}

	@Override
	public List<WordVO> getList() {
		return mapper.readList();
	}

	@Override
	public List<WordVO> getListByCategoryId(Long categoryId) {
		return mapper.readListByCategoryId(categoryId);
	}

	@Override
	public List<WordVO> getListWithPaging(Long categoryId, Criteria criteria) {
		return mapper.readListWithPaging(categoryId, criteria);
	}

	@Override
	public int getTotalCount(Long categoryId) {
		return mapper.readTotalCount(categoryId);
	}

	@Override
	public List<WordVO> getListByRownum(Long rownum, Long bookId) {
		return mapper.readListByRownum(rownum, bookId);
	}

	@Override
	public Long getRownumByCategoryId(Long categoryId, Long bookId) {
		return mapper.readRownumByCategoryId(categoryId, bookId);
	}




}
