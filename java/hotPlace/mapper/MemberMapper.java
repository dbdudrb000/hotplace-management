package collabo.wato.springboot.web.member.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import collabo.wato.springboot.web.common.vo.CommonVO;
import collabo.wato.springboot.web.member.vo.MemberVO;

@Repository
@Mapper
public interface MemberMapper {

	// 회원 조회
	List<MemberVO> getMember(MemberVO vo);
	// 회원 가입
	public void insertMember(MemberVO vo);
	// 회원 수정
	public void updateMemeber(MemberVO vo);
	// 회원 차단
	public void preventMemeber(MemberVO vo);

	// SMS인증
	void upsertAuthCode(Map<String, Object> map);
	// SMS인증 체크
	CommonVO selectAuthCode(String phone_number);
	// divide 좋아요 관리
	void upsertLike(MemberVO mvo);
	// divide 좋아요 조회
	List<MemberVO> selectLike (MemberVO mvo);
	
	
	
}
