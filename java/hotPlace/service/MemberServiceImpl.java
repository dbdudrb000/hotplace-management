package collabo.wato.springboot.web.member.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import collabo.wato.springboot.web.common.vo.CommonVO;
import collabo.wato.springboot.web.member.mapper.MemberMapper;
import collabo.wato.springboot.web.member.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	private static final String String = null;
	@Autowired
	MemberMapper memberDao;	

	@Override
	public List<MemberVO> getMember(MemberVO vo) throws Exception {
		return memberDao.getMember(vo);
	}

	@Override
	public void insertMember(MemberVO vo) throws Exception {
		 memberDao.insertMember(vo);
	}

	@Override
	public void updateMemeber(MemberVO vo) throws Exception {
		 memberDao.updateMemeber(vo);
	}

	@Override
	public void preventMemeber(MemberVO vo) throws Exception {
		 memberDao.preventMemeber(vo);
	}

	@Override
	public void upsertAuthCode(String phone_number, int auth_key) {
		Map<String, Object> map = new HashedMap();
		map.put("phone_number", phone_number);
		map.put("auth_key", auth_key);
		
		System.out.println("upsertAuthCode =>  phone_number : " + phone_number );
		memberDao.upsertAuthCode(map);
	}

	@Override
	public CommonVO selectAuthCode(String phone_number) {
		return memberDao.selectAuthCode(phone_number);
	}
	
	// 회원이 좋아요 클릭했을때 기능 번호 등록
	@Override
	public void upsertLike(MemberVO mvo) throws Exception {
		System.out.println("조항요!!" + mvo.getCs_like());
		System.out.println("닉네임 : >> " + mvo.getNickname());
		memberDao.upsertLike(mvo);
	}

	// 회원의 좋아요 기능 번호 조회
	@Override
	public List<MemberVO> selectLike(MemberVO mvo) throws Exception {
		
		System.out.println("서비스 이메일 : "+mvo.getEmail());
		
		return memberDao.selectLike(mvo);
		
	}

	
}
