package edu.coldrain.domain;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class CategoryVO {

	// 카테고리 아이디 AUTO SEQUENCE
	private Long categoryId;
	
	// 카테고리 이름 UNIQUE
	private String categoryName;
	
	// 책 아이디 UNIQUE
	private Long bookId;
	
	// 등록일 DEFAULT SYSDATE
	private Date regdate;
	
	// 수정일 DEFAULT SYSDATE
	private Date updatedate;
	
	// 카테고리 언어
	private String language;
	
	public CategoryVO(String categoryName, Long bookId) {
		this.categoryName = categoryName;
		this.bookId = bookId;
	}
	
}
