package edu.coldrain.mapper;

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
public class WordMapperTests {

	@Autowired
	private WordMapper mapper;
	
	@Test
	public void testExist() {
		log.info(mapper);
	}
	
	@Test
	public void testInsert() {
		WordVO wordVO = new WordVO("INSERT", "삽입하다", 23L);
		int count = mapper.insert(wordVO);
		
		log.info("INSERT COUNT = " + count);
	}
	
	@Test
	public void testRead() {
		WordVO wordVO = mapper.read(30L);
		log.info("WORD_VO = " + wordVO);
	}
	
	@Test
	public void testUpdate() {
		WordVO wordVO = mapper.read(30L);
		wordVO.setWordName("UPDATE");
		wordVO.setWordMeaning("갱신하다");
		
		int count = mapper.update(wordVO);
		log.info("UPDATE COUNT = " + count);		
	}
	
	@Test
	public void testDelete() {
		int count = mapper.delete(30L);
		log.info("DELETE COUNT = " + count);
	}
	
	@Test
	public void testReadList() {
		List<WordVO> list = mapper.readList();
		list.forEach(word -> log.info(word));
	}
	
	@Test
	public void testReadListByCategoryId() {
		List<WordVO> list = mapper.readListByCategoryId(23L);
		list.forEach(word -> log.info(word));
	}
	
}
