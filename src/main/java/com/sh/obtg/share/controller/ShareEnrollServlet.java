package com.sh.obtg.share.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.sh.mvc.board.model.dto.Attachment;
import com.sh.mvc.common.HelloMvcFileRenamePolicy;
import com.sh.obtg.share.model.dto.ShareBoard;


@WebServlet("/share/shareEnroll")
public class ShareEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	private ShareService shareService = new ShareService();

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/share/shareEnroll.jsp").forward(request, response);
	}

	
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			// 0. MultipartRequest객체 생성 - 요청메세지에서 파일을 읽어(Input), 서버컴퓨터에 저장(Output)까지 처리
			String saveDirectory = getServletContext().getRealPath("/uploadshare/Share"); // 웹루트디렉토리(src/main/webapp)부터 탐색
			System.out.println(saveDirectory);
			
			int maxPostSize = 10 * 1024 * 1024; // byte단위 : 1kb-1024, 1mb-1024*1kb
			
			String encoding = "utf-8";
			
			FileRenamePolicy policy = new HelloMvcFileRenamePolicy(); // 년월일_시분초밀리초_난수.txt 
			

			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
			
			// 1. 사용자입력값 처리 - request가 아닌 MultipartRequest에서 값 꺼내기
			String title = multiReq.getParameter("title");
			String writer = multiReq.getParameter("writer");
			String content = multiReq.getParameter("content");
			
			ShareBoard share = new ShareBoard();
			share.setShareTitle(title);
			share.setMember_id(writer);
			share.setShareContent(content);
			
			// 업로드한 파일처리
			if(multiReq.getFile("upFile1") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("upFile1"));
				attach.setRenamedFilename(multiReq.getFilesystemName("upFile1"));
				share.addAttachment(attach);
			}
			
			if(multiReq.getFile("upFile2") != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName("upFile2"));
				attach.setRenamedFilename(multiReq.getFilesystemName("upFile2"));
				share.addAttachment(attach);
			}
			
			// 2. 업무로직 insert into board (no, title, writer, content) values (seq_board_no.nextval, ?, ?, ?)
//			int result = ShareService.insertShare(share);

			// 3. 리다이렉트
//			response.sendRedirect(request.getContextPath() + "/Share/ShareView?no=" + share.getShareNo());
			
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("msg", "게시글 등록중 오류가 발생했습니다.");
			response.sendRedirect(request.getContextPath() + "/share/shareList");
		}
		
		
		
	}

}
