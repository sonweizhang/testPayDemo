package demo;

import java.io.IOException;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import net.sf.json.JSONObject;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import base.ProcessMessage;

/**
 * Servlet implementation class DecodeDemo
 */
@WebServlet("/DecodeDemo")
public class DecodeDemo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DecodeDemo() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String base64Data = URLDecoder.decode(request.getParameter("sourceData"),"UTF-8");
		Map<String, String> map = new HashMap<String, String>();
		
		//解析base64串
		String xmlString = new String(base.ProcessMessage.Base64Decode(base64Data),"GBK");
		System.out.println("base64解析："+xmlString);//解码用GBK
		
		map.put("base64Data", base64Data);
		map.putAll(xmlParse(xmlString));
		
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
		String base64Data = URLDecoder.decode(request.getParameter("sourceData"),"UTF-8");
		Map<String, String> map = new HashMap<String, String>();
		
		//解析base64串
		String xmlString = new String(base.ProcessMessage.Base64Decode(base64Data),"GBK");
		System.out.println("base64解析："+xmlString);//解码用GBK
		
		map.put("base64Data", base64Data);
		map.putAll(xmlParse(xmlString));
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		JSONObject json=new JSONObject();
		json.accumulateAll(map);
		
		response.getWriter().println(json.toString());
	}
	
	/**
	 * XML数据解析，网上解析方法有很多，这里只选取其中一种
	 * @param xmlString XML字符串
	 */
	private Map<String, String> xmlParse(String xmlString){
		Map<String, String> map = new HashMap<String, String>();
		try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new InputSource(new StringReader(xmlString)));
            
            Element root = doc.getDocumentElement();
            NodeList books = root.getChildNodes();
           if (books != null) {
               for (int i = 0; i < books.getLength(); i++) {
                    Node book = books.item(i);
                    if (book.getFirstChild() != null) {
                    	System.out.println(book.getNodeName() + " : "
                    			+ book.getFirstChild().getNodeValue());
                    	map.put(book.getNodeName(), book.getFirstChild().getNodeValue());
					}
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		return map;
	}

	public static void main(String[] args) {
		String base64="PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iR0JLIiA/PjxCMkNSZXA+PGJhbmtDb3VudD43PC9iYW5rQ291bnQ+PGJhbmtMaXN0PjxiYW5rUm93PjxiYW5rTmFtZT7S+MGqyKvH/rXAPC9iYW5rTmFtZT48YmFua0lEPjg4OEI8L2JhbmtJRD48b3RoZXJCYW5rSUQ+ODg4Qjwvb3RoZXJCYW5rSUQ+PGNhcmRUeXBlPjAxPC9jYXJkVHlwZT48L2JhbmtSb3c+PGJhbmtSb3c+PGJhbmtOYW1lPtL4warIq8f+tcA8L2JhbmtOYW1lPjxiYW5rSUQ+ODg4QzwvYmFua0lEPjxvdGhlckJhbmtJRD44ODhDPC9vdGhlckJhbmtJRD48Y2FyZFR5cGU+MDE8L2NhcmRUeXBlPjwvYmFua1Jvdz48YmFua1Jvdz48YmFua05hbWU+0vjBqsmowus8L2JhbmtOYW1lPjxiYW5rSUQ+OTY5QzwvYmFua0lEPjxvdGhlckJhbmtJRD45NjlDPC9vdGhlckJhbmtJRD48Y2FyZFR5cGU+MDE8L2NhcmRUeXBlPjwvYmFua1Jvdz48YmFua1Jvdz48YmFua05hbWU+1qe4trGmQVBQ1qe4tjwvYmFua05hbWU+PGJhbmtJRD45ODBDPC9iYW5rSUQ+PG90aGVyQmFua0lEPjk4MEM8L290aGVyQmFua0lEPjxjYXJkVHlwZT5YPC9jYXJkVHlwZT48L2JhbmtSb3c+PGJhbmtSb3c+PGJhbmtOYW1lPsPxyfrOotDFuavW2rrF1qe4tjwvYmFua05hbWU+PGJhbmtJRD45OTNDPC9iYW5rSUQ+PG90aGVyQmFua0lEPjk5M0M8L290aGVyQmFua0lEPjxjYXJkVHlwZT4wMTwvY2FyZFR5cGU+PC9iYW5rUm93PjxiYW5rUm93PjxiYW5rTmFtZT7D8cn6zqLQxcmowus8L2JhbmtOYW1lPjxiYW5rSUQ+OTk0QzwvYmFua0lEPjxvdGhlckJhbmtJRD45OTRDPC9vdGhlckJhbmtJRD48Y2FyZFR5cGU+MDE8L2NhcmRUeXBlPjwvYmFua1Jvdz48YmFua1Jvdz48YmFua05hbWU+w/HJ+tanuLaxpsmowus8L2JhbmtOYW1lPjxiYW5rSUQ+OTk1QzwvYmFua0lEPjxvdGhlckJhbmtJRD45OTVDPC9vdGhlckJhbmtJRD48Y2FyZFR5cGU+WDwvY2FyZFR5cGU+PC9iYW5rUm93PjwvYmFua0xpc3Q+PC9CMkNSZXA+";
		String xmlString;
		try {
			xmlString = new String(ProcessMessage.Base64Decode(base64),"GBK");
			System.out.println(xmlString);
			DecodeDemo xmlToMap=new DecodeDemo();
			Map<String, String> map=xmlToMap.xmlParse(xmlString);
			System.out.println(map.toString());
			String ss=map.remove("bankCount");
			System.out.println(ss);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}
}
