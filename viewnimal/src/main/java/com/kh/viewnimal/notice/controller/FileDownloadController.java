package com.kh.viewnimal.notice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component("filedown")
public class FileDownloadController extends AbstractView {


	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		File readFile = (File)model.get("readFile");
		File downFile = (File)model.get("downFile");
		
		response.setContentType("text/plain; charset=UTF-8");
		
		response.addHeader("Content-Disposition", "attachment; filename=\""
				+ new String(downFile.getName().getBytes("UTF-8"), "ISO-8859-1") + "\"");
		response.setContentLength((int)readFile.length());
		
		OutputStream out = response.getOutputStream();
		FileInputStream fin = new FileInputStream(readFile);
		
		FileCopyUtils.copy(fin, out);
		out.flush();
		out.close();
		fin.close();
	}
	


}