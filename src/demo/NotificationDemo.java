package demo;

import java.io.IOException;
import java.io.StringReader;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import base.CertTools;
import base.DigestUtil;
import base.ProcessMessage;

/**
 * Servlet implementation class NotificationDemo
 */
@WebServlet("/NotificationDemo")
public class NotificationDemo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String KEY = "123123";//商户签名密钥

    /**
     * Default constructor. 
     */
    public NotificationDemo() {}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String interfaceName = request.getParameter("interfaceName");
		String tranDataBase64 = request.getParameter("tranData");
		String signData = request.getParameter("signData");
		String version = request.getParameter("version");
		String tranData = new String(ProcessMessage.Base64Decode(tranDataBase64),"GBK");//通知base64解密用GBK
		
		System.out.println("-------doGet处理开始-------");
		System.out.println("interfaceName:" + interfaceName);
		System.out.println("tranDataBase64:" + tranDataBase64);
		System.out.println("signData:" + signData);
		System.out.println("version:" + version);
		
		System.out.println("-------签名验证-------");
		String mySignMsg = DigestUtil.hmacSign(tranData, KEY);
		System.out.println("验签结果：" + mySignMsg.equals(signData));
		
		System.out.println("-------tranData解析-------");
		System.out.println("tranData:" + tranData);
		
		System.out.println("-------tranData字段获取-------");
		xmlParse(tranData);
		System.out.println("-------doget处理完成-------");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String interfaceName = request.getParameter("interfaceName");
		String tranDataBase64 = request.getParameter("tranData");
		String signData = request.getParameter("signData");
		String version = request.getParameter("version");
		String tranData = new String(ProcessMessage.Base64Decode(tranDataBase64),"GBK");//通知base64解密用GBK
		
		System.out.println("-------doPost处理开始-------");
		System.out.println("interfaceName:" + interfaceName);
		System.out.println("tranDataBase64:" + tranDataBase64);
		System.out.println("signData:" + signData);
		System.out.println("version:" + version);
		
		System.out.println("-------签名验证-------");
		//用MD5和ITRUS两种方式，测试时按需选择，后续只保留ITRUS方式。
		//MD5方式
//		String mySignMsg = DigestUtil.hmacSign(tranData, KEY);
//		System.out.println("验签结果：" + mySignMsg.equals(signData));
		//ITRUS方式
		System.out.println("验签结果：" + CertTools.verifyMessage(signData, tranData, "GBK"));
		
		System.out.println("-------tranData解析-------");
		System.out.println("tranData:" + tranData);
		
		System.out.println("-------tranData字段获取-------");
		xmlParse(tranData);
		System.out.println("-------doPost处理完成-------");
	}
	
	private void xmlParse(String xmlString){
		try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new InputSource(new StringReader(xmlString)));
            
            Element root = doc.getDocumentElement();
            NodeList books = root.getChildNodes();
           if (books != null) {
               for (int i = 0; i < books.getLength(); i++) {
                    Node book = books.item(i);
                    System.out.println(book.getNodeName() + " : "
                            + book.getFirstChild().getNodeValue());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

}
