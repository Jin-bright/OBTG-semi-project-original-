package com.sh.obtg.ootd.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.sh.obtg.common.OotdFileRenamePolicy;
import com.sh.obtg.ootd.model.dto.OotdAttachment;
import com.sh.obtg.ootd.model.dto.OotdBoard;
import com.sh.obtg.ootd.model.dto.Style;
import com.sh.obtg.ootd.model.service.OotdBoardService;

/**
 * Servlet implementation class OotdUpdateServlet
 */
@WebServlet("/ootd/ootdUpdate")
public class OotdUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OotdBoardService ootdBoardService = new OotdBoardService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. jsp에 내용넣기 
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println("no = " + no);
		
		
		//2. 업무로직 
		OotdBoard board = ootdBoardService.selectOneBoard(no);		
		System.out.println( "board = "  + board );
		
		
		request.setAttribute("board", board);
		request.getRequestDispatcher("/WEB-INF/views/ootd/ootdUpdate.jsp")
		.forward(request, response);
	}
	
	
		
		
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 0. MultipartRequest객체 생성 - 요청메세지에서 파일을 읽어서(=input) 서버컴퓨터에서 저장 (=output) 까지 처리해준다 
		// -- (HttpServletRequest arg0, String arg1, int arg2, String arg3, FileRenamePolicy arg4) throws IOException 
		// 1. HttpServletRequest자리 / 2. String saveDirectory(실제저장할파일경로)/ 3.업로드할수있는파일최대크기 (꼭정해야됨) 일반파일은 10mb정도/ 4.인코딩(utf-8) / 5.파일이름정책객체? - 중복파일이 있는경우 어떻게할거냐  

		
			String saveDirectory = getServletContext().getRealPath("/uploadootds/ootd"); //application 객체 반환  //  / <-- webroot를 가리킨다
			System.out.println("saveDirectory : " + saveDirectory  );
			
			int maxPostSize = 10*1024*1024;  //바이트단위로 줘야됨 (1kb = 1024byte  1mb - 1024*1kb ? )  
			String encoding = "utf-8";
			
			FileRenamePolicy policy = new OotdFileRenamePolicy(); //년월일_시분초밀리초_난수.tx  이렇게 만들거임 
			//중복파일이 있는 경우, abc1.txt, abc2.txt 이런씩으로 네이밍을 다르게해줌 
			// 이자리에 우리꺼를 써야된다 ? (파일명 변경하려면 )
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			// 이까지 하면 파일이 서버컴텨에 저장된다 --서버저장하는거까지끝 --- 
			// 여기까지 하고 . request가 아닌  MultipartRequest multiReq 값 꺼내는걸로 다 변경해줘야됨 

			int no = Integer.parseInt(multiReq.getParameter("no")); //hidden으로 가져오는거맞음 ^^ 
			System.out.println("게시글번호 : " + no);
			
		    // 1. 사용자입력값 처리
			String ootdtitle = multiReq.getParameter("ootdtitle");
			String ootdwriter = multiReq.getParameter("ootdwriter");
			String ootdTop = multiReq.getParameter("ootdTop");
			String ootdBottom = multiReq.getParameter("ootdBottom");
			String ootdShoes = multiReq.getParameter("ootdShoes");
			String ootdEtc = multiReq.getParameter("ootdEtc");
			String _style = multiReq.getParameter("style");
			Style style = Style.valueOf(_style);

			String[] delFiles = multiReq.getParameterValues("delFile");

		
			String ootdContents = multiReq.getParameter("editordata");
			
			System.out.println(" _style : " + _style );
			System.out.println(" **style : " + style );
			
			
			OotdBoard ootdBoard = new OotdBoard();
			ootdBoard.setOotdWriter(ootdwriter);
			ootdBoard.setStyleNo(style);
			ootdBoard.setOOTDTitle(ootdtitle);
			ootdBoard.setOOTDTop(ootdTop);
			ootdBoard.setOOTDBottom(ootdBottom);
			ootdBoard.setOOTDShoes(ootdShoes);
			ootdBoard.setOOTDEtc(ootdEtc);
			ootdBoard.setOOTDContents(ootdContents);

			System.out.println( "**ootdBoard " + ootdBoard);
			
			//업로드한 파일처리 
			if( multiReq.getFile("upFile1") !=null ) {
				OotdAttachment ootdAttach = new OotdAttachment();
				ootdAttach.setOriginalFilename(multiReq.getOriginalFileName("upFile1"));
				ootdAttach.setRenamedFilename( multiReq.getFilesystemName("upFile1")); 		// 2. 파일명 변경 (original -> renamed )?
				ootdBoard.addAttachment(ootdAttach);	
			}
						
				

				
		//  이거 내가한거  	int result = boardService.insertBoardContent(title, memberId, content);
//  - 쿼리 정하기 - dml - insert into board values(여기 sequence 맞는지확인하기 ,?,?,?,default,default); 
//insert into OOTD_board values( seq_board_no.nextval, 'tigerhj','S1','TIGER의OOTD','오늘의ootdㅎ',default,default,'나이키','나이키','나이키','없음');

	//2. 업무로직 - 쿼리 insertBoard = insert into board (no, title, writer, content) values (seq_board_no.nextval, ?, ?, ?)
	    	int result = ootdBoardService.updateBoard(ootdBoard); // board에 싹다넣어서 서비스요청 코드는 이거 하나임 ★★★★★내가한방식은안돼 
	    	System.out.println( "성공 ??? " + result );
	    	
	    	
	    	if(delFiles != null) {
	    		for(String temp : delFiles) {
	    			int attachNo = Integer.parseInt( temp );
	    			OotdAttachment attach = ootdBoardService.selectOneAttachment(attachNo); //저장된 파일 이름 찾아와야된다 (board하위) 이넘버는 no인가  ?
	    			System.out.println("attachNo 이거뭔데  : " + attachNo  ); // 첨부파일 no => 그럼 Attachment 테이블에서 no네 
	    			File delFile = new File( saveDirectory, attach.getRenamedFilename() ); // 실제파일이아닌 자바객체임 얘는 
	    			
	    			//1)파일삭제
	    			if(delFile.exists()) {
	    				delFile.delete();
	    			}
	    			//2)attachment 행삭제
	    			result = ootdBoardService.deleteAttachment(attachNo); //delete from attachment where no = ? 
	    			
	    		}
	    	}
			
		
			System.out.println("오류발생");
			
			request.getSession().setAttribute("msg", "게시글 수정 중 오류가 발생했습니다." );
			response.sendRedirect(request.getContextPath()+"/ootd/ootdView?no=" + ootdBoard.getOotdNo() );
		
	    // 리다이렉트는 : board/boardList로 가게 -  메세지는 너무 뻔한경우는 걍 쓰지마 (왜냐면 이 글은 제일 최신으로 등록되니까 바로 확인가능 )

	}

}
