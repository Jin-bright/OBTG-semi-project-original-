package com.sh.obtg.ootd.model.dto;

public class OotdBoard {
	
	private int ootdNo;
	private String ootdWriter;
	private Style styleNo;
	private String OOTDTitle;
	private String OOTDContents;
	private int OOTDReadCount;
	private String OOTDTop;
	private String OOTDBottom;
	private String OOTDShoes;
	private String OOTDEtc;

	
	public OotdBoard() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public OotdBoard(int ootdNo, String ootdWriter, Style styleNo, String oOTDTitle, String oOTDContents,
			int oOTDReadCount, String oOTDTop, String oOTDBottom, String oOTDShoes, String oOTDEtc) {
		super();
		this.ootdNo = ootdNo;
		this.ootdWriter = ootdWriter;
		this.styleNo = styleNo;
		OOTDTitle = oOTDTitle;
		OOTDContents = oOTDContents;
		OOTDReadCount = oOTDReadCount;
		OOTDTop = oOTDTop;
		OOTDBottom = oOTDBottom;
		OOTDShoes = oOTDShoes;
		OOTDEtc = oOTDEtc;
	}
	
	
	public int getOotdNo() {
		return ootdNo;
	}


	public void setOotdNo(int ootdNo) {
		this.ootdNo = ootdNo;
	}


	public String getOotdWriter() {
		return ootdWriter;
	}


	public void setOotdWriter(String ootdWriter) {
		this.ootdWriter = ootdWriter;
	}


	public Style getStyleNo() {
		return styleNo;
	}


	public void setStyleNo(Style styleNo) {
		this.styleNo = styleNo;
	}


	public String getOOTDTitle() {
		return OOTDTitle;
	}


	public void setOOTDTitle(String oOTDTitle) {
		OOTDTitle = oOTDTitle;
	}


	public String getOOTDContents() {
		return OOTDContents;
	}


	public void setOOTDContents(String oOTDContents) {
		OOTDContents = oOTDContents;
	}


	public int getOOTDReadCount() {
		return OOTDReadCount;
	}


	public void setOOTDReadCount(int oOTDReadCount) {
		OOTDReadCount = oOTDReadCount;
	}


	public String getOOTDTop() {
		return OOTDTop;
	}


	public void setOOTDTop(String oOTDTop) {
		OOTDTop = oOTDTop;
	}


	public String getOOTDBottom() {
		return OOTDBottom;
	}


	public void setOOTDBottom(String oOTDBottom) {
		OOTDBottom = oOTDBottom;
	}


	public String getOOTDShoes() {
		return OOTDShoes;
	}


	public void setOOTDShoes(String oOTDShoes) {
		OOTDShoes = oOTDShoes;
	}


	public String getOOTDEtc() {
		return OOTDEtc;
	}


	public void setOOTDEtc(String oOTDEtc) {
		OOTDEtc = oOTDEtc;
	}

	
	
	@Override
	public String toString() {
		return "OotdBoard [ootdNo=" + ootdNo + ", ootdWriter=" + ootdWriter + ", styleNo=" + styleNo + ", OOTDTitle="
				+ OOTDTitle + ", OOTDContents=" + OOTDContents + ", OOTDReadCount=" + OOTDReadCount + ", OOTDTop="
				+ OOTDTop + ", OOTDBottom=" + OOTDBottom + ", OOTDShoes=" + OOTDShoes + ", OOTDEtc=" + OOTDEtc + "]";
	}
	
	
}


/**
CREATE TABLE OOTD_board (
OOTD_no	number,
OOTD_writer	varchar2(50)		NOT NULL,
style_no	varchar2(10)		NOT NULL,
OOTD_title	varchar2(50)		NOT NULL,
OOTD_contents	varchar2(4000)	NOT NULL,
OOTD_read_count	number		default 0,
OOTD_reg_date	date		default sysdate,
OOTD_top	varchar2(50)		NULL,
OOTD_bottom	varchar2(50)		NULL,
OOTD_shoes	varchar2(50)		NULL,
OOTD_etc	varchar2(50)		NULL,
CONSTRAINT PK_OOTD_BOARD PRIMARY KEY (OOTD_no),
CONSTRAINT FK_OOTD_board_writer FOREIGN KEY (ootd_writer) REFERENCES Member (member_id) on delete set null,
CONSTRAINT FK_fashionstyle_TO_OOTD_board_1 FOREIGN KEY (style_no) REFERENCES fashionstyle (style_no) on delete set null
);
**/
