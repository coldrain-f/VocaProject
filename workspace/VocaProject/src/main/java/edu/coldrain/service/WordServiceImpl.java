package edu.coldrain.service;

import java.util.List;

import org.springframework.stereotype.Service;

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

}
