package collabo.wato.springboot.web.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import collabo.wato.springboot.web.board.vo.BoardVO;

@Repository
@Mapper
public interface BoardMapper {

	//조회
	public List<BoardVO> selectBoard(BoardVO vo);
	//주소 조회 
	public List<BoardVO> selectBoardAddress(BoardVO vo);
	//등록
	public void insertBoard(BoardVO vo);
	//수정
	public void updateBoard(BoardVO vo);
	//삭제
	public void deleteBoard(BoardVO vo);
		
}
