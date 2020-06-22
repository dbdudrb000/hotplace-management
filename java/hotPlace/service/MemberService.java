package collabo.wato.springboot.web.member.service;

import java.util.List;

import collabo.wato.springboot.web.common.vo.CommonVO;
import collabo.wato.springboot.web.hotPlace.vo.AdministratorVO;
import collabo.wato.springboot.web.hotPlace.vo.PostVO;
import collabo.wato.springboot.web.member.vo.MemberVO;

public interface MemberService {
	
	// 회원 조회
	public List<MemberVO> getMember(MemberVO vo) throws Exception;
	// 회원 가입
	public void insertMember(MemberVO vo) throws Exception;
	// 회원 수정
	public void updateMemeber(MemberVO vo) throws Exception;
	// 회원 차단
	public void preventMemeber(MemberVO vo) throws Exception;
	
	//SMS 인증번호
	public void upsertAuthCode(String phone_number, int auth_key);
	//SMS 인증번호 체크
	public CommonVO selectAuthCode(String phone_number);
	// divde 좋아요 등록
	public void upsertLike(MemberVO mvo) throws Exception;
	
	// divide 좋아요 조회
	public List<MemberVO>selectLike(MemberVO mvo) throws Exception;
	
	
	
}
