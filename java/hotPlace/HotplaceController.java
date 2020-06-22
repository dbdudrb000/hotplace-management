package collabo.wato.springboot.web.hotPlace;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import collabo.wato.springboot.web.board.service.BoardService;
import collabo.wato.springboot.web.board.vo.BoardVO;
import collabo.wato.springboot.web.hotPlace.service.AdministratorService;
import collabo.wato.springboot.web.hotPlace.service.PostService;
import collabo.wato.springboot.web.member.service.MemberService;
import collabo.wato.springboot.web.member.vo.MemberVO;

@Controller
public class HotplaceController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	AdministratorService administratorService;
	@Autowired
	PostService postService;
	@Autowired
	BoardService boardservice;
	@RequestMapping(value = "/hotplace", method = RequestMethod.GET)
	public String dongho(HttpServletResponse response, HttpServletRequest request) throws Exception{
		
		//List<MemberVO> membervoList = memberService.selectMemberList();
		MemberVO vo = new MemberVO();
		List<MemberVO> membervoList = memberService.getMember(vo);
		
		request.setAttribute("data",membervoList );
		
		return "main/test";
	}
		// �������������� �α���â���� ������ �̵��� ���ִ� controller
	
	@RequestMapping(value = "/loginView")
	public String login(HttpServletResponse response, HttpServletRequest request) {
		
		return "main/login/loginView";
	}
	
		//  �α��ΰ����� �����ϴ� controller
	
	@RequestMapping(value = "/loginLogic")
	public String loginLogic(HttpServletResponse response, HttpServletRequest request, HttpSession httpSession) throws Exception {
		boolean result = true;
		String email = request.getParameter("email");
		String pw = request.getParameter("password");					  		 
		MemberVO vo = new MemberVO();
		vo.setEmail(email);
		
		List<MemberVO> voList = memberService.getMember(vo);
		if( voList != null && voList.size() > 0 ) {
			if(!"Y".equals(voList.get(0).getAvailable())) {
				request.setAttribute("isAvailable", voList.get(0).getAvailable());
				return "forward:/kakao";
			}else {
				httpSession.setAttribute("loginVO",voList.get(0));
			}
		}else {
			result = false;
		}
		
		request.setAttribute("result", result);		
		return "forward:/kakao";
		
	}
	
	@RequestMapping(value = "/logoutLogic")
	public String logoutLogic(HttpServletResponse response, HttpServletRequest request, HttpSession httpSession) throws Exception {
		// session 영역으로 로인한 회원정보 올린다..
		httpSession.invalidate();
		return "redirect:/kakao";
	}
	
		// 메인페이지로 이동하는 controller
	@RequestMapping(value = "/mainView")
	public String MainView(HttpServletResponse response, HttpServletRequest request) {
		
		return "main/mainView";
		
	}
	
	// 회원가입 페이지로 이동하는 controller
	@RequestMapping(value = "/joinView")
	public String join(HttpServletResponse response, HttpServletRequest request) {
		System.out.println("������");
		return "/main/join/joinView";
		
	}
	
	// 회원가입 로직을 실행하는 controller
	@RequestMapping(value = "/joinLogic")
	public String joinLogic(HttpServletRequest request, HttpServletResponse response) {
		
		String email = request.getParameter("email");
		String pw = request.getParameter("password1");
		String nickname = request.getParameter("nickname");
		String address = request.getParameter("address");
		
		System.out.println(email);
		System.out.println(pw);
		System.out.println(nickname);
		System.out.println(address);
		
		return "/main/join/joinResult";
	}
	
	@RequestMapping(value = "/kakao")
	public String kakao(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		BoardVO vo = new BoardVO();
		List<BoardVO> boardList = boardservice.selectBoard(vo);
		
		List<BoardVO> addressList = boardservice.selectBoardAddress(vo);
		
		for (int i = 0; i < addressList.size(); i++) {
			if(!(addressList.get(i).getPkid2().isEmpty())) {
				String[] sub_city = addressList.get(i).getPkid2().split(",");
				addressList.get(i).setSub_city(sub_city);
			}
		}

		request.setAttribute("boardList", boardList);
		request.setAttribute("addressList", addressList);
		 
		return "/main/kakaoMap/kakao2";
	}
	
	@RequestMapping(value = "/menu")
	public String menu(HttpServletRequest request, HttpServletResponse response) {
		return "/main/kakaoMap/menuParameter";
	}
}