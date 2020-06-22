package collabo.wato.springboot.web.board;

import java.io.File;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import collabo.wato.springboot.web.board.service.BoardService;
import collabo.wato.springboot.web.board.vo.BoardVO;

@Controller
public class BoardController {

	@Autowired
	BoardService service;
	
	@RequestMapping("/board")
	public String main(HttpServletRequest request) throws Exception {
		BoardVO vo = new BoardVO();
		String boardid = request.getParameter("boardid");

		if(boardid != null && !"".equals(boardid)) {
			vo.setBoardid(boardid);
			vo = service.selectBoard(vo).get(0);
		
		}
		System.out.println(vo.getFilepath() + "이미지@@@@@@@@");
		request.setAttribute("boardVO", vo);
		return "/main/board/board";
	}

	@RequestMapping("/board/insert")
	public String insert(HttpServletRequest request, HttpServletResponse Response, MultipartFile files) throws Exception {
		String title = request.getParameter("title");
		String address = request.getParameter("addr_hidden");
		String imgsrc = request.getParameter("imgsrc");
		String feiling = request.getParameter("feiling");
		String main = request.getParameter("main");
		String dtAddress = request.getParameter("dtAddress");
		String nickname = request.getParameter("nickname");
		
		 String[] dtAddress2 = dtAddress.split("(" + "," + ")");
		 		 
		 SimpleDateFormat sdf = new SimpleDateFormat ( "yyyyMMdd");
		 String time = sdf.format (System.currentTimeMillis());
		 String fileName = (UUID.randomUUID().toString() + time).replace("-", "") + ".jpg";
//		 String fileName = files.getOriginalFilename();
		 File file = new File("C:\\hotplace\\img\\" + fileName);
		 files.transferTo(file);
		 
		BoardVO vo = new BoardVO();
		vo.setTitle(title); 		// 제목
		vo.setBoard_address(address);
		vo.setDetail(main);
		vo.setFeeling(feiling);
		vo.setLat(dtAddress2[1]);
		vo.setLng(dtAddress2[0]);
		vo.setCreate_user(nickname);
		vo.setFilepath(fileName);

		service.insertBoard(vo);
		
		
		return "redirect:/kakao";
	}
	@RequestMapping("/board/update")
	public String update(@ModelAttribute BoardVO vo, HttpServletRequest request, HttpServletResponse response, MultipartFile files) throws Exception {
		
		String title = request.getParameter("title");
		String address = request.getParameter("addr_hidden");
		String feeling = request.getParameter("feiling");
		String main = request.getParameter("main");
		String boardid = request.getParameter("boardid");
		
		//기존 이미지 파일명
		String fileName = request.getParameter("path");//파일명
		 
		 if(!files.isEmpty()) {
			 //파일이 있으면
			 //기존 파일 삭제
			 System.out.println("기존 파일명 : " + fileName);
			 File file = new File("C:\\hotplace\\img\\" + fileName);
			 if(file.exists()) {
				 System.out.println("나(" + fileName + ") 있어요!");
				 System.out.println(file.getPath());
				 file.setWritable(true);
				 boolean isDelete = file.delete();
				 System.err.println("너 지워졌니 ? : " + isDelete);
			 }
			 
			 //대체 파일 생성
			 SimpleDateFormat sdf = new SimpleDateFormat ( "yyyyMMdd");
			 String time = sdf.format (System.currentTimeMillis());
			 String updateimg  = (UUID.randomUUID().toString() + time).replace("-", "") + ".jpg";
			 File updateFile = new File("C:\\hotplace\\img\\" + updateimg);
			 System.out.println("대체 파일명 : " + updateimg);
			 
			 files.transferTo(updateFile);			 
			 vo.setFilepath(updateimg);
		 }
		 
		
		vo.setBoardid(boardid);
		vo.setTitle(title);
		vo.setBoard_address(address);
		vo.setFeeling(feeling);
		vo.setDetail(main);
		service.updateBoard(vo);

		return "forward:/board";
	}
	
	@RequestMapping("/board/delete")
	public String delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		BoardVO vo = new BoardVO();
		
		String boardid = request.getParameter("boardid");
		String create_user = request.getParameter("create_user");
		request.setAttribute("create_user", create_user);
		vo.setBoardid(boardid);
		
		service.deleteBoard(vo);
		
		return "forward:/board/myboard";
	}
	
	// 추억게시글 가는 controller
	@RequestMapping("/board/allBoard")
	public String select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
	
		BoardVO vo = new BoardVO();
		String boardid = request.getParameter("boardid");

		if(boardid != null && !"".equals(boardid)) {
			vo.setBoardid(boardid);
		}
		
		
		
		List<BoardVO> boardList = service.selectBoard(vo);
		
		 String fileName = vo.getFilepath();
		 File file = new File("C:\\hotplace\\img\\" + fileName);		
		request.setAttribute("imgfile", file);
		
		request.setAttribute("boardList", boardList);
		
		return "/main/board/allBoard";
	}
	
	@RequestMapping("/board/myboard")
	public String myboard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardVO vo = new BoardVO();
		
		// 카카오 메인페이지에서 로그인한 회원의 닉네임을 가져온것이다.
		String create_user = request.getParameter("create_user");
		
		vo.setCreate_user(create_user);
		System.out.println();
		List<BoardVO> myBoard = service.selectBoard(vo);	
		request.setAttribute("myBoard", myBoard);
		return "/main/board/myboard";
	}
	
	@RequestMapping("/board/img")
	@ResponseBody
	public void imgReturn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String project = request.getParameter("project");
		String path = request.getParameter("path");

		StringBuilder sb = new StringBuilder();
		
		if("codingstreet".equals(project)) {
			// divide project img 불러오기 ( 파일경로 )
			sb = new StringBuilder("file:C:\\divide\\img\\" + path);
		}else {
			System.out.println("카카오");
			// kakao project img 불러오기 ( 파일경로 )
			//sb = new StringBuilder("file:\\\\BRODY\\hotplace\\img\\" + path);
			sb = new StringBuilder("file:C:\\hotplace\\img\\" + path);
		}
		
		URL fileUrl = new URL(sb.toString());
		IOUtils.copy(fileUrl.openStream(), response.getOutputStream());
		
	}

	@RequestMapping("/board/searchAllBoard")
	public String search(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String search = request.getParameter("search");
		
		BoardVO vo = new BoardVO();
		vo.setSearch(search);

		List<BoardVO> searchList = service.selectBoard(vo);
		
			request.setAttribute("boardList", searchList);	
			return "/main/board/allBoard";			
	}
	
	@ResponseBody
	@RequestMapping("/board/ajax")
	public HashMap<String, Object> ajaxBoard(HttpServletRequest request) throws Exception {
		BoardVO vo = new BoardVO();
		String swLatlng = request.getParameter("swLatlng").replaceAll("\\(", "").replaceAll("\\)", "");
		String neLatlng = request.getParameter("neLatlng").replaceAll("\\(", "").replaceAll("\\)", "");
		String[] swlatArry = swLatlng.split(",");
		String[] neLatlngArry = neLatlng.split(",");

		// 좌표셋팅
		vo.setSwLatlngFrom(swlatArry[0]);
		vo.setSwLatlngTo(swlatArry[1]);
		vo.setNeLatlngFrom(neLatlngArry[0]);
		vo.setNeLatlngTo(neLatlngArry[1]);
		
		List<BoardVO> voList = service.selectBoard(vo);
		request.setAttribute("voList", voList);
		
		HashMap<String, Object> map = new HashMap<String, Object> (); 
		map.put("list", voList);
		
		return map;
	}
	
}
