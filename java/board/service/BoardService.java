package collabo.wato.springboot.web.board.service;

import java.util.List;

import collabo.wato.springboot.web.board.vo.BoardVO;

public interface BoardService {

	//조회
	List<BoardVO> selectBoard(BoardVO vo) throws Exception;
	//주소 조회
	List<BoardVO> selectBoardAddress(BoardVO vo) throws Exception;
	//등록
	void insertBoard(BoardVO vo) throws Exception;
	//수정
	void updateBoard(BoardVO vo) throws Exception;
	//삭제
	void deleteBoard(BoardVO vo) throws Exception;
	
}
