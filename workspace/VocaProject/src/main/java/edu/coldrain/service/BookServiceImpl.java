package edu.coldrain.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.coldrain.domain.BookVO;
import edu.coldrain.mapper.BookMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {

	private final BookMapper mapper;
	
	/**
	 * 책 레코드 하나를 추가하는 기능을 수행한다.
	 * @param BookVO 추가할 책 모델
	 * @return boolean 레코드가 정상적으로 추가 되었으면 true 실패하면 false
	 */
	@Override
	public boolean register(BookVO bookVO) {
		return ( mapper.insert(bookVO) == 1 );
	}

	/**
	 * 책 레코드 하나를 조회하는 기능을 수행한다.
	 * @param Long 책 아이디
	 * @return BookVO 조회한 책 모델
	 */
	@Override
	public BookVO get(Long bookId) {
		return mapper.read(bookId);
	}

	/**
	 * 책 레코드 하나를 수정하는 기능을 수행한다.
	 * @param BookVO 수정할 책 모델
	 * @return boolean 레코드가 정상적으로 수정 되었으면 true 실패하면 false
	 */
	@Override
	public boolean modify(BookVO bookVO) {
		return ( mapper.update(bookVO) == 1 );
	}

	/**
	 * 책 레코드 하나를 삭제하는 기능을 수행한다.
	 * @param Long 책 아이디
	 * @return boolean 레코드가 정상적으로 삭제 되었으면 true 실패하면 false
	 */
	@Override
	public boolean remove(Long bookId) {
		return ( mapper.delete(bookId) == 1 );
	}

	/**
	 * 모든 책 레코드 목록을 조회하는 기능을 수행한다.
	 * @return List<BookVO> 조회된 모든 책 레코드 모델 리스트 
	 */
	@Override
	public List<BookVO> getList() {
		return mapper.readList();
	}
}
