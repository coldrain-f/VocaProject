package edu.coldrain.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import edu.coldrain.domain.BookVO;
import edu.coldrain.domain.Criteria;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BookMapperTests {

	@Autowired
	private BookMapper mapper;
	
	@Test
	public void testExist() {
		log.info(mapper);
	}
	
	@Test
	public void testInsert() {
		BookVO bookVO = new BookVO("단어가 읽기다 테스트편3");
		int count = mapper.insert(bookVO);
		
		log.info("INSERT COUNT = " + count);
		log.info("BOOK_VO = " + bookVO);
	}
	
	@Test
	public void testRead() {
		BookVO bookVO = mapper.read(5L);
		log.info("BOOK_VO = " + bookVO);
	}
	
	@Test
	public void testUpdate() {
		BookVO bookVO = mapper.read(47L);
		bookVO.setBookName("단어가 읽기다 수정편");
		
		int count = mapper.update(bookVO);
		log.info("UPDATE COUNT = " + count);
	}
	
	@Test
	public void testDelete() {
		int count = mapper.delete(47L);
		log.info("DELETE COUNT = " + count);
	}
	
	@Test
	public void testReadList() {
		List<BookVO> list = mapper.readList();
		list.forEach(book -> log.info(book));
	}
	
	@Test
	public void testReadListWithPaging() {
		List<BookVO> books = mapper.readListWithPaging(new Criteria());
		books.forEach(book -> log.info(books));
	}
	
	@Test
	public void testReadListWithPaging2() {
		List<BookVO> books = mapper.readListWithPaging(new Criteria(2, 10));
		books.forEach(book -> log.info(books));
	}
	
	@Test
	public void testReadTotalCount() {
		int totalCount = mapper.readTotalCount();
		log.info(totalCount);
	}
}
