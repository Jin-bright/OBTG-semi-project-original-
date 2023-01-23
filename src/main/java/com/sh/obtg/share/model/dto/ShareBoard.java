package com.sh.obtg.share.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

<<<<<<< HEAD

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
=======
import com.sh.mvc.board.model.dto.Attachment;

public class ShareBoard {
	private int ShareNo;
	private String member_id;
	private String ShareTitle;
	private String ShareContent;
	private int ShareReadCount;
	private Date ShareRegDate;
	private Date ShareBuyDate;
	private String ShareProductStatus;
	private String ShareCategory;
	private String ShareState;
	private Style Style;
	

	public ShareBoard() {
		super();
	}
	
	
	
	
	
	
	public ShareBoard(int shareNo, String member_id, String shareTitle, String shareContent, int shareReadCount,
			Date shareRegDate, Date shareBuyDate, String shareProductStatus, String shareCategory, String shareState,
			com.sh.obtg.share.model.dto.Style style) {
		super();
		ShareNo = shareNo;
		this.member_id = member_id;
		ShareTitle = shareTitle;
		ShareContent = shareContent;
		ShareReadCount = shareReadCount;
		ShareRegDate = shareRegDate;
		ShareBuyDate = shareBuyDate;
		ShareProductStatus = shareProductStatus;
		ShareCategory = shareCategory;
		ShareState = shareState;
		Style = style;
	}






	public int getShareNo() {
		return ShareNo;
	}


	public void setShareNo(int shareNo) {
		ShareNo = shareNo;
	}

	public String getMember_id() {
		return member_id;
	}




	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}




	public String getShareTitle() {
		return ShareTitle;
	}




	public void setShareTitle(String shareTitle) {
		ShareTitle = shareTitle;
	}




	public String getShareContent() {
		return ShareContent;
	}




	public void setShareContent(String shareContent) {
		ShareContent = shareContent;
	}




	public int getShareReadCount() {
		return ShareReadCount;
	}




	public void setShareReadCount(int shareReadCount) {
		ShareReadCount = shareReadCount;
	}




	public Date getShareRegDate() {
		return ShareRegDate;
	}




	public void setShareRegDate(Date shareRegDate) {
		ShareRegDate = shareRegDate;
	}




	public Date getShareBuyDate() {
		return ShareBuyDate;
	}




	public void setShareBuyDate(Date shareBuyDate) {
		ShareBuyDate = shareBuyDate;
	}




	public String getShareProductStatus() {
		return ShareProductStatus;
	}




	public void setShareProductStatus(String shareProductStatus) {
		ShareProductStatus = shareProductStatus;
	}




	public String getShareCategory() {
		return ShareCategory;
	}




	public void setShareCategory(String shareCategory) {
		ShareCategory = shareCategory;
	}




	public String getShareState() {
		return ShareState;
	}




	public void setShareState(String shareState) {
		ShareState = shareState;
	}




	public Style getStyle() {
		return Style;
	}




	public void setStyle(Style style) {
		Style = style;
	}






	public void addAttachment(Attachment attach) {
//		this.attachments.add(attach);
	}




>>>>>>> branch 'master' of https://github.com/incheol789/OBTG-semi-project.git
}


<<<<<<< HEAD
	public void addAttachment(ShareAttachment attach) {
		this.attachments.add(attach);
	}
	
	
	
	
}



=======
>>>>>>> branch 'master' of https://github.com/incheol789/OBTG-semi-project.git
