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
public class BookVO {

	// 책 아이디 AUTO SEQUENCE
	private Long bookId;

	// 책 이름 UNIQUE
	private String bookName;

	// 등록일 DEFAULT SYSDATE
	private Date regdate;

	// 수정일 DEFAULT SYSDATE
	private Date updatedate;
	
	public BookVO(String bookName) {
		this.bookName = bookName;
	}
}