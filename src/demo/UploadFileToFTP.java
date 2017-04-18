package demo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.comparator.DefaultFileComparator;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;

/**
 * Servlet implementation class UploadFileToFTP
 */
@WebServlet("/UploadFileToFTP")
public class UploadFileToFTP extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadFileToFTP() {
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
		String path = getServletContext().getRealPath("/upload");
		String realPath = getServletContext().getContextPath()+"/upload";
		System.out.println("path:"+path);
		System.out.println("realPath:"+realPath);
		
		String ftpFileName = request.getParameter("ftpFileName2");
		String merchantId = request.getParameter("merchantId3");
		System.out.println("ftpFileName:"+ftpFileName);
		System.out.println("merchantId:"+merchantId);
		
		Part part = request.getPart("ftpFile");
		String fileName = "e:\\temp";
		part.write(fileName);
	}

}
