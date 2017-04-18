package demo;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.misc.BASE64Encoder;

import net.sf.json.JSONObject;

import base.CertTools;
import base.DigestUtil;
import base.ProcessMessage;

/**
 * Servlet implementation class EncryptDemo
 */
@WebServlet("/EncryptDemo")
public class EncryptDemo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EncryptDemo() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sourceData = URLDecoder.decode(request.getParameter("sourceData"),"UTF-8");
		String encryptType = request.getParameter("encryptType");
		String signKey = request.getParameter("signKey");
		
		System.out.println("接收到encryptType："+encryptType);
		///////////////  base64加密用GBK编码    //////////////////
		String tranData = ProcessMessage.Base64Encode(sourceData.getBytes(Charset.forName("GBK")));
		String signMsg = "";
		if ("MD5".equalsIgnoreCase(encryptType)) {
			System.out.println("签名模式：MD5");
			signMsg = DigestUtil.hmacSign(sourceData, signKey);
		}
		if ("ITRUS".equalsIgnoreCase(encryptType)) {
			System.out.println("签名模式：ITRUS");
			signMsg = CertTools.signMessage(tranData);
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("tranData", tranData);
		map.put("signMsg", signMsg);
		
		System.out.println("tranData："+sourceData);
		System.out.println("生成base64："+tranData);
		System.out.println("签名秘钥："+signKey);
		System.out.println("生成签名："+signMsg);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		JSONObject json=new JSONObject();
		json.accumulateAll(map);
		
		response.getWriter().println(json.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sourceData = URLDecoder.decode(request.getParameter("sourceData"),"UTF-8");
		String encryptType = request.getParameter("encryptType");
		String signKey = request.getParameter("signKey");
		
		System.out.println("接收到encryptType："+encryptType);
		System.out.println("接收到sourceData："+sourceData);
		///////////////  base64加密用GBK编码    //////////////////
//		String tranData = new BASE64Encoder().encode(sourceData.getBytes(Charset.forName("GBK")));
		String tranData = ProcessMessage.Base64Encode(sourceData.getBytes(Charset.forName("GBK")));
		String signMsg = "";
		if ("MD5".equalsIgnoreCase(encryptType)) {
			System.out.println("签名模式：MD5");
			signMsg = DigestUtil.hmacSign(sourceData, signKey);
		}
		if ("ITRUS".equalsIgnoreCase(encryptType)) { 
			System.out.println("签名模式：ITRUS");
			signMsg = CertTools.signMessage(sourceData);
			//签名自检
			System.out.println("签名自检:"+CertTools.verifyMessage(signMsg, sourceData, "UTF-8"));
		}
		if (encryptType == null) {
			System.out.println("签名模式为null，默认MD5");
			signMsg = DigestUtil.hmacSign(sourceData, "123123");
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("tranData", tranData);
		map.put("signMsg", signMsg);
		
		System.out.println("tranData："+sourceData);
		System.out.println("生成base64："+tranData);
		System.out.println("签名秘钥："+signKey);
		System.out.println("生成签名："+signMsg);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		JSONObject json=new JSONObject();
		json.accumulateAll(map);
		
		System.out.println("json : "+json);
		response.getWriter().println(json.toString());
	}

}
