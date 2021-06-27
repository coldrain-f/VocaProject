package edu.coldrain.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import edu.coldrain.domain.WordVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class WordServiceTests {

	@Autowired
	private WordService service;
	
	@Test
	public void testExist() {
		log.info(service);
	}
	
	@Test
	public void testRegister() {
		WordVO wordVO = new WordVO("REGISTER", "등록하다", 23L);
		boolean success = service.register(wordVO);
		
		log.info("REGISTER SUCCESS = " + success);
	}
	
	@Test
	public void testGet() {
		WordVO wordVO = service.get(31L);
		log.info("WORD_VO = " + wordVO);
	}
	
	@Test
	public void testModify() {
		WordVO wordVO = service.get(31L);
		wordVO.setWordName("MODIFY");
		wordVO.setWordMeaning("수정하다");
		
		boolean success = service.modify(wordVO);
		log.info("MODIFY SUCCESS = " + success);
	}
	
	@Test
	public void testRemove() {
		boolean success = service.remove(31L);
		log.info("REMOVE SUCCESS = " + success);
	}
	
	@Test
	public void testGetList() {
		List<WordVO> list = service.getList();
		list.forEach(word -> log.info(word));
	}
	
	@Test
	public void testGetListByCategoryId() {
		List<WordVO> list = service.getListByCategoryId(23L);
		list.forEach(word -> log.info(word));
	}
}
