package com.sh.obtg.share.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;


//import com.sh.mvc.board.model.dto.Attachment;

public class ShareBoard extends ShareEntity {
	
	private int attachCnt;
	private List<ShareAttachment> attachments = new ArrayList<>();
	
	public ShareBoard() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public ShareBoard(int ShareNo, String member_id, String ShareTitle, String ShareContent, int ShareReadCount, Date ShareRegDate, Date ShareBuyDate, String ShareProductStatus, String ShareCategory, String ShareState, Style Style, int attachCnt) {
		super(ShareNo, member_id, ShareTitle, ShareContent, ShareReadCount, ShareRegDate, ShareBuyDate, ShareProductStatus, ShareCategory, ShareState, Style);
		this.attachCnt = attachCnt;
	}
	
	public ShareBoard(int ShareNo, String member_id, String ShareTitle, String ShareContent, int ShareReadCount, Date ShareRegDate, Date ShareBuyDate, String ShareProductStatus, String ShareCategory, String ShareState, Style Style, List<ShareAttachment> attachments) {
		super(ShareNo, member_id, ShareTitle, ShareContent, ShareReadCount, ShareRegDate, ShareBuyDate, ShareProductStatus, ShareCategory, ShareState, Style);
		this.attachCnt = attachCnt;
	}

	public int getAttachCnt() {
		return attachCnt;
	}

	public void setAttachCnt(int attachCnt) {
		this.attachCnt = attachCnt;
	}
	
	

	public List<ShareAttachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<ShareAttachment> attachments) {
		this.attachments = attachments;
	}
	
	




	@Override
	public String toString() {
		return "ShareBoard [attachCnt=" + attachCnt + ", attachments=" + attachments + ", toString()=" + super.toString()
		+ "]";
}


	public void addAttachment(ShareAttachment attach) {
		this.attachments.add(attach);
	}
	
	
	
	
}



