package collabo.wato.springboot.web.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import collabo.wato.springboot.web.board.mapper.BoardMapper;
import collabo.wato.springboot.web.board.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper mapper;
	
	//조회
	@Override
	public List<BoardVO> selectBoard(BoardVO vo) throws Exception {
		return mapper.selectBoard(vo); 
	}
	//주소 조회
	@Override
	public List<BoardVO> selectBoardAddress(BoardVO vo) throws Exception {
		return mapper.selectBoardAddress(vo); 
	}
	//등록
	@Override
	public void insertBoard(BoardVO vo) throws Exception {
		mapper.insertBoard(vo); 
	}
	//수정
	@Override
	public void updateBoard(BoardVO vo) throws Exception {
		mapper.updateBoard(vo); 
	}
	//삭제
	@Override
	public void deleteBoard(BoardVO vo) throws Exception {
		mapper.deleteBoard(vo); 
	}

}
