package com.sh.obtg.share.model.dto;

import java.sql.Date;

public class ShareAttachment {
	private int attachNo;
	private int boardNo;
	private String originalFilename;
	private String renamedFilename;
	private Date regDate;
	
<<<<<<< HEAD
	
	
	
	public ShareAttachment() {
		super();
		// TODO Auto-generated constructor stub
	}




	public ShareAttachment(int attachNo, int boardNo, String originalFilename, String renamedFilename, Date regDate) {
		super();
		this.attachNo = attachNo;
		this.boardNo = boardNo;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
		this.regDate = regDate;
	}




	public int getAttachNo() {
		return attachNo;
	}




	public void setAttachNo(int attachNo) {
		this.attachNo = attachNo;
	}




	public int getBoardNo() {
		return boardNo;
	}




	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}




	public String getOriginalFilename() {
		return originalFilename;
	}




	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}




	public String getRenamedFilename() {
		return renamedFilename;
	}




	public void setRenamedFilename(String renamedFilename) {
		this.renamedFilename = renamedFilename;
	}




	public Date getRegDate() {
		return regDate;
	}




	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}




	@Override
	public String toString() {
		return "ShareAttachment [attachNo=" + attachNo + ", boardNo=" + boardNo + ", originalFilename="
				+ originalFilename + ", renamedFilename=" + renamedFilename + ", regDate=" + regDate + "]";
	}
=======

	public ShareAttachment() {
		super();
	}


	public ShareAttachment(int attachNo, int boardNo, String originalFilename, String renamedFilename, Date regDate) {
		super();
		this.attachNo = attachNo;
		this.boardNo = boardNo;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
		this.regDate = regDate;
	}


	public int getAttachNo() {
		return attachNo;
	}


	public void setAttachNo(int attachNo) {
		this.attachNo = attachNo;
	}


	public int getBoardNo() {
		return boardNo;
	}


	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}


	public String getOriginalFilename() {
		return originalFilename;
	}


	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}


	public String getRenamedFilename() {
		return renamedFilename;
	}


	public void setRenamedFilename(String renamedFilename) {
		this.renamedFilename = renamedFilename;
	}


	public Date getRegDate() {
		return regDate;
	}


	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}


	@Override
	public String toString() {
		return "ShareAttachment [attachNo=" + attachNo + ", boardNo=" + boardNo + ", originalFilename="
				+ originalFilename + ", renamedFilename=" + renamedFilename + ", regDate=" + regDate + "]";
	}
	
>>>>>>> branch 'master' of https://github.com/incheol789/OBTG-semi-project.git
	
	
	
}


