package demo;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import base.WXSignUtils;
@WebServlet("/sign")
public class AddSign  extends HttpServlet{
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Map<String, String> map1 = new HashMap<String, String>();
    	map1.put("sign",request.getParameter("sign"));
    	map1.put("orderAmt", request.getParameter("orderAmt"));
    	map1.put("curType" , request.getParameter("curType"));
    	map1.put("bankId" , request.getParameter("bankId"));
    	map1.put("returnURL" , request.getParameter("returnURL"));
    	map1.put("notifyURL" , request.getParameter("notifyURL"));
    	map1.put("remark" , request.getParameter("remark"));
    	map1.put("cardType" , request.getParameter("cardType"));
    	map1.put("userId" , request.getParameter("userId"));
    	map1.put("goodsType" , request.getParameter("goodsType"));
    	map1.put("goodsName" , request.getParameter("goodsName"));

		SortedMap mapParams=new TreeMap(map1);
		String sign=WXSignUtils.createSign("UTF-8", mapParams);
		System.out.print("sign>>>>>>>>>>>>>>>>>"+sign);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("sign", sign);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		JSONObject json=new JSONObject();
		json.accumulateAll(map);
		
		System.out.println("json : "+json);
		response.getWriter().println(json.toString());
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
