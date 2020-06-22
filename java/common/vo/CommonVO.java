package collabo.wato.springboot.web.common.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper = true)
@Alias("commonVO")
public class CommonVO implements Serializable {

	static final String SUCCESS = "S";
	static final String ERROR = "E";
	static final String BUSY = "B";
	private String create_dt = "";
	private String create_user = "";
	private String update_dt = "";
	private String update_user = "";
	private String wato_user_id = "";
	
	private String create_dtFrom = "";
	private String create_dtTo = "";
	private String update_dtFrom = "";
	private String update_dtTo = "";
	
	/**
	 * 파일
	 * */
	private String fileid = "";
	private String filenm = "";
	private String fileurl = "";
	private String filepath = "";
	private String filetpcd = "";
	private String pkid1 = "";
	private String pkid2 = "";
	private String pkid3 = "";
	
	private String profile_url = "";

	/**
	 * Others
	 */
	private int req_cnt = 0;
	private int max_cnt = 0;
	private int auth_key = 0;
	
}
