package demo;

import it.sauronsoftware.ftp4j.FTPAbortedException;
import it.sauronsoftware.ftp4j.FTPClient;
import it.sauronsoftware.ftp4j.FTPDataTransferException;
import it.sauronsoftware.ftp4j.FTPException;
import it.sauronsoftware.ftp4j.FTPFile;
import it.sauronsoftware.ftp4j.FTPIllegalReplyException;
import it.sauronsoftware.ftp4j.FTPListParseException;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.SocketException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import net.sf.json.JSONObject;

import org.apache.commons.io.comparator.DefaultFileComparator;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;

/**
 * Servlet implementation class UploadFileToFTP
 */
@WebServlet("/CheckFTPFile")
public class CheckFTPFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckFTPFile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ftpFileName = request.getParameter("ftpFileName");
		String merchantId = request.getParameter("merchantId");
		System.out.println("ftpFileName:"+ftpFileName);
		System.out.println("merchantId:"+merchantId);
		
		String FTP_ip = "60.12.221.84";// FTPIP地址
		String FTP_port = "2100";// FTP端口
		String FTP_username = merchantId;// FTP用户名
		String FTP_password = merchantId;// FTP密码
		String FTP_path = "\\pilianghuikuan";// FTP服务器上存放上传文件的目录

		FTPClient ftpClient = null;
		boolean ifExist = false;
		try {
			ftpClient = new FTPClient();
			ftpClient.setCharset("UTF-8");
			// 连接FTP服务器
			ftpClient.connect(FTP_ip, Integer.parseInt(FTP_port));
			System.out.println("连接FTP服务器成功");
			// 登录FTP服务器
			ftpClient.login(FTP_username, FTP_password);
			System.out.println("登录FTP服务器成功");
			ftpClient.setType(FTPClient.TYPE_BINARY);
			
			// 查找文件
			ftpClient.changeDirectory(FTP_path);
			FTPFile[] files = ftpClient.list();
			
			for (int i = 0; i < files.length; i++) {
				FTPFile ftpFile = files[i];
				if(ftpFile.getName().equalsIgnoreCase(ftpFileName)){
					System.out.println(ftpFile.getName()+"文件已找到");
					ifExist = true;
					break;
				}
			}
			
		} catch (SocketException e) {
			System.out.println("连接FTP服务器失败：" + e.getMessage());
		} catch (IllegalStateException e) {
			System.out.println("连接FTP服务器失败：" + e.getMessage());
		} catch (FTPIllegalReplyException e) {
			System.out.println("连接FTP服务器失败：" + e.getMessage());
		} catch (FTPException e) {
			System.out.println("连接FTP服务器失败：" + e.getMessage());
		} catch (FTPDataTransferException e) {
			System.out.println("连接FTP服务器失败：" + e.getMessage());
		} catch (FTPAbortedException e) {
			System.out.println("连接FTP服务器失败：" + e.getMessage());
		} catch (FTPListParseException e) {
			System.out.println("连接FTP服务器失败：" + e.getMessage());
		} finally {
			if(null != ftpClient)
				try {
					ftpClient.logout();
				} catch (IllegalStateException e1) {
					System.out.println("退出FTP服务器失败：" + e1.getMessage());
				} catch (FTPIllegalReplyException e1) {
					System.out.println("退出FTP服务器失败：" + e1.getMessage());
				} catch (FTPException e1) {
					System.out.println("退出FTP服务器失败：" + e1.getMessage());
				}
			if (ftpClient.isConnected()) {
				try {
					ftpClient.disconnect(true);
				} catch (IOException e) {
					System.out.println("退出FTP服务器失败：" + e.getMessage());
				} catch (IllegalStateException e) {
					System.out.println("退出FTP服务器失败：" + e.getMessage());
				} catch (FTPIllegalReplyException e) {
					System.out.println("退出FTP服务器失败：" + e.getMessage());
				} catch (FTPException e) {
					System.out.println("退出FTP服务器失败：" + e.getMessage());
				}
			}
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		JSONObject json=new JSONObject();
		
		json.accumulate("ifExist", ifExist);
		System.out.println("json : "+json);
		response.getWriter().println(json.toString());
		
	}
	

}
