package edu.coldrain.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.coldrain.domain.CategoryVO;
import edu.coldrain.mapper.CategoryMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

	private final CategoryMapper mapper;
	
	@Override
	public boolean register(CategoryVO categoryVO) {
		return ( mapper.insert(categoryVO) == 1 );
	}

	@Override
	public CategoryVO get(Long categoryId) {
		return mapper.read(categoryId);
	}

	@Override
	public boolean modify(CategoryVO categoryVO) {
		return ( mapper.update(categoryVO) == 1 );
	}

	@Override
	public boolean remove(Long categoryId) {
		return ( mapper.delete(categoryId) == 1 );
	}

	@Override
	public List<CategoryVO> getList() {
		return mapper.readList();
	}

	@Override
	public List<CategoryVO> getListByBookId(Long bookId) {
		return mapper.readListByBookId(bookId);
	}

}
