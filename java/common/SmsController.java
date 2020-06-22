package collabo.wato.springboot.web.common;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import collabo.wato.springboot.web.common.vo.CommonVO;
import collabo.wato.springboot.web.member.service.MemberService;

/***
 * https://www.coolsms.co.kr/Legacy_API 참조 ( 건당 20원 )
 * @author Brody Wato
 */

@RestController
public class SmsController {

	@Autowired
	MemberService memberService;
	
	//문자를 보낼때 맵핑되는 메소드
    @RequestMapping(value = "/sendSms")
    public JSONObject sendSms(HttpServletRequest request, @RequestBody Map<String, Object> param) throws Exception {
//    	Enumeration enumeration = request.getParameterNames();
//    	while (enumeration.hasMoreElements()) {
//    	String key = (String) enumeration.nextElement();
//    	String value = request.getParameter(key);
//    	System.out.println(">>> " + key + " : " + value);
//    	}
    	
      System.out.println(param.toString());
    	
      String api_key = "NCSCCNIIVWQJQOON"; //위에서 받은 api key를 추가
      String api_secret = "YVMEACP7HNW2XXVNLYWOFYSKC3ACIVJ0";  //위에서 받은 api secret를 추가

      Coolsms coolsms = new Coolsms(api_key, api_secret);
      //이 부분은 홈페이지에서 받은 자바파일을 추가한다음 그 클래스를 import해야 쓸 수 있는 클래스이다.
      
      Util util = new Util();
      util.setCertNumLength(6);
      int rInt = Integer.parseInt(util.excuteGenerate());
      
      System.out.println("인증 번호 6자리 : " + rInt );
      System.out.println("전화 번호  : [ " +  param.get("phone_number") + " ]");

      //핸드폰 번호와 인증 번호 저장
      memberService.upsertAuthCode((String) param.get("phone_number"), rInt); // 휴대폰 인증 관련 서비스
      
      String msg = "핫플레이스 인증 번호 : [ " + rInt + " ] 문의 전화번호 1588-0011";
      HashMap<String, String> set = new HashMap<String, String>();
      set.put("to", (String) param.get("phone_number")); // 수신번호
      set.put("from", "01029545558"); // 발신번호, jsp에서 전송한 발신번호를 받아 map에 저장한다.
      set.put("text", msg); // 문자내용, jsp에서 전송한 문자내용을 받아 map에 저장한다.
      set.put("type", "sms"); // 문자 타입

      System.out.println(set);

      JSONObject result = coolsms.send(set); // 보내기&전송결과받기

      if ((boolean)result.get("status") == true) {

        // 메시지 보내기 성공 및 전송결과 출력
        System.out.println("성공");
        System.out.println(result.get("group_id")); // 그룹아이디
        System.out.println(result.get("result_code")); // 결과코드
        System.out.println(result.get("result_message")); // 결과 메시지
        System.out.println(result.get("success_count")); // 메시지아이디
        System.out.println(result.get("error_count")); // 여러개 보낼시 오류난 메시지 수
      } else {

        // 메시지 보내기 실패
        System.out.println("실패");
        System.out.println(result.get("code")); // REST API 에러코드
        System.out.println(result.get("message")); // 에러메시지
      }

      return result;
    }

    //인증 번호 체크
    @RequestMapping(value = "/sendSms/check")
    public JSONObject check(HttpServletRequest request, @RequestBody Map<String, Object> param) throws Exception {
    	JSONObject result = new JSONObject();
    	String phone_number = (String) param.get("phone_number");
    	String msg = (String) param.get("msg");
    	
    	if(!msg.isEmpty()) {
    		CommonVO vo = new CommonVO();
    		vo = memberService.selectAuthCode(phone_number);
    		int authKey = vo.getAuth_key(); 
    		if( vo.getReq_cnt() >= vo.getMax_cnt()) {
    			result.put("status", false);
    			result.put("msg", "인증 허용 횟수를 초과하였습니다.\n문의해주시기 바랍니다.");
    		}
    		else if ( msg.equals(authKey+"") ) {
    			result.put("status", true);
    			result.put("msg", "인증되었습니다.");
    		}else {
    			result.put("status", false);
    			result.put("msg", "인증번호를 확인해주세요.");
    		}
    	}else {
    		result.put("status", false);
    		result.put("msg", "예외 에러.");
    	}
    
    	return result;
    }
    
}
