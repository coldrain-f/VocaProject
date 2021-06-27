package edu.coldrain.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import edu.coldrain.domain.BookVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BookServiceTests {

	@Autowired
	private BookService service;
	
	@Test
	public void testExist() {
		log.info(service);
	}
	
	@Test
	public void testRegister() {
		BookVO bookVO = new BookVO("BOOK REGISTER");
		boolean success = service.register(bookVO);
		
		log.info("REGISTER SUCCESS = " + success);
	}
	
	@Test
	public void testGet() {
		BookVO bookVO = service.get(48L);
		log.info("BOOK_VO = " + bookVO);
	}
	
	@Test
	public void testModify() {
		BookVO bookVO = service.get(48L);
		bookVO.setBookName("BOOK MODIFY");
		
		boolean success = service.modify(bookVO);
		log.info("MODIFY SUCCESS = " + success);
	}
	
	@Test
	public void testRemove() {
		boolean success = service.remove(48L);
		log.info("DELETE SUCCESS = " + success);
	}
	
	@Test
	public void testGetList() {
		List<BookVO> list = service.getList();
		list.forEach(bookVO -> log.info(bookVO));
	}
}
