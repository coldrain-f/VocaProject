package edu.coldrain.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import edu.coldrain.domain.CategoryVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CategoryMapperTests {
	
	@Autowired
	private CategoryMapper mapper;
	
	@Test
	public void testExist() {
		log.info(mapper);
	}
	
	@Test
	public void testInsert() {
		CategoryVO categoryVO = new CategoryVO("Unit 00 - 테스트", 44L);
		
		int count = mapper.insert(categoryVO);
		log.info("INSERT COUNT = " + count);
	}
	
	@Test
	public void testRead() {
		CategoryVO categoryVO = mapper.read(28L);
		
		log.info("CATEGORY_VO = " + categoryVO);
	}
	
	@Test
	public void testUpdate() {
		CategoryVO categoryVO = mapper.read(28L);
		categoryVO.setCategoryName("Unit 00 - 테스트 (수정)");
		
		int count = mapper.update(categoryVO);
		
		log.info("UPDATE COUNT = " + count);
	}
	
	@Test
	public void testDelete() {
		int count = mapper.delete(28L);
		
		log.info("DELETE COUNT = " + count);
	}
	
	@Test
	public void testReadList() {
		List<CategoryVO> list = mapper.readList();
		list.forEach(category -> log.info(category));
	}
	
	@Test
	public void testReadListByBookId() {
		List<CategoryVO> list = mapper.readListByBookId(5L);
		list.forEach(category -> log.info(category));
	}
}
