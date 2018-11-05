package com.kh.viewnimal.lab.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.freeboard.model.dto.FreeBoardDto;
import com.kh.viewnimal.lab.model.dto.LabDto;
import com.kh.viewnimal.lab.model.service.LabService;
import com.kh.viewnimal.member.model.dto.MemberDto;

@Controller
public class LabController{

	@Autowired
	private LabService labService;

	// 연구소 리스트 
	@RequestMapping("Lab")
	public ModelAndView selectLabList(HashMap<String, Integer> paging, ModelAndView mv, HttpServletRequest request){
		int currentPage = 1, countList = 4, countPage = 5;
		
		if(request.getParameter("page") != null){
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		int totalCount = labService.selectCountLab();
		int maxPage = totalCount / countList;
		if(totalCount % countList > 0)
			maxPage++;
		
		if(maxPage < currentPage)
			currentPage = maxPage;
		
		int startPage = ((currentPage - 1) / countPage) * countPage + 1;
		int endPage = startPage + countPage -1;
		
		if(endPage > maxPage)
			endPage = maxPage;
		
		int startrow = (currentPage - 1) * countList + 1;
		paging.put("startrow", startrow);
		paging.put("endrow", startrow + countList - 1);
		
		
		mv.addObject("pageSubType", "Lab");
		mv.addObject("list", labService.selectLabList(paging));
		mv.addObject("currentPage", currentPage);
		mv.addObject("maxPage", maxPage);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("totalCount", totalCount);
		mv.setViewName("client/lab/labList");
		
		
		return mv;
	}
		
	// 연구소 상세페이지
	@RequestMapping("LabDetail")
	public ModelAndView selectLabDetail(@RequestParam(value="no") int no, ModelAndView mv){
		
		mv.addObject("pageSubType", "Lab");
		
		labService.selectLabDetail(no);
		mv.addObject("Lab", labService.selectLabDetail(no));
		mv.setViewName("client/lab/labDetail");	
		return mv;
	}
	

	// 연구소 글 작성 페이지 이동
	@RequestMapping("LabWrite")
	public ModelAndView moveWriteLab(ModelAndView mv){
		mv.addObject("pageSubType", "Lab");
		
		mv.setViewName("client/lab/labWrite");	
		
		return mv;
	}
	
	// 연구소 글 작성
	@RequestMapping(value="insertLab", method = RequestMethod.POST)
	public ModelAndView insertLab(ModelAndView mv, HttpServletRequest request, LabDto lab, @RequestParam(value="imgListArr", required=false) String imgListArr) throws Exception{
		
		JSONParser jsonParser = new JSONParser();
		ArrayList<String> imgList = (ArrayList<String>)jsonParser.parse(imgListArr);
		String resultMessage = "fail";
		
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("loginMemberDto");
		lab.setId(memberDto.getId());
		
		if(imgList != null){
			String resourcesPath = request.getSession().getServletContext().getRealPath("resources");
			resourcesPath = resourcesPath.replaceAll("resources", "");
			
			File fileDirectory = new File(resourcesPath + "/resources/images/lab/successImages");
			
			if(!fileDirectory.exists()){
				fileDirectory.mkdirs();
			}
			
			String contentTag = lab.getContent_tag();
			
			for(int i = 0 ; i < imgList.size(); i++){
				File cachFile = new File(resourcesPath + imgList.get(i));
				String realFileSrc = imgList.get(i).replaceAll("cachUploadImages", "successImages");
				File realFile = new File(resourcesPath + realFileSrc);
				
				
				if(!cachFile.renameTo(realFile)){
					int read = -1;
					byte[] bt = new byte[1024];
					
					FileInputStream fin = new FileInputStream(cachFile);
					FileOutputStream fout = new FileOutputStream(realFile);
					
					while((read = fin.read(bt, 0, bt.length)) != -1){
						fout.write(bt, 0, read);
						
					}
					
					fin.close();
					fout.close();
					cachFile.delete();
				}
				
				contentTag = contentTag.replaceAll(imgList.get(i), realFileSrc);
				
				if(i == 0){
					lab.setThumbnail(realFileSrc);
					
				}
			}
			
			lab.setContent_tag(contentTag);
			
			File temporaryFile = new File(resourcesPath + "/resources/images/lab/cachUploadImages");
			
			if(temporaryFile.exists()){
				File[] deleteFolderList = temporaryFile.listFiles();
				
				for(int j = 0 ; j < deleteFolderList.length; j++){
					deleteFolderList[j].delete();
				}
				
				if(deleteFolderList.length == 0 && temporaryFile.isDirectory()){
					temporaryFile.delete();
					
				}
			}
		}
		
		if(labService.insertLab(lab) > 0){
			resultMessage = "success";
		}
		
		mv.addObject("resultMessage", resultMessage);
		mv.setViewName("jsonView");
		
		
		return mv;
	}
	
	@RequestMapping(value="labFileUpload", method = RequestMethod.POST)
	public ModelAndView labFileUpload(HttpServletRequest request, ModelAndView mv, @RequestParam(name="file") MultipartFile file) throws Exception {
		
		String savePath = request.getSession().getServletContext().getRealPath("resources/images/lab/cachUploadImages");
		
		String originalFileName = file.getOriginalFilename();
		String renameFileName = null;
		
		if(originalFileName != null){
			File fileDirectory = new File(savePath);
			
			if(!fileDirectory.exists()){
				fileDirectory.mkdirs();
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "_" + ((int)(Math.random()*100000)+1) + "." +originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
			
			
			file.transferTo(new File(savePath + "//" + file.getOriginalFilename()));
			
			File originFile = new File(savePath + "//" + originalFileName);
			File renameFile = new File(savePath + "//" + renameFileName);
			
			
			if(!originFile.renameTo(renameFile)){
				int read = -1;
				byte[] bt = new byte[1024];
				
				FileInputStream fin = new FileInputStream(originFile);
				FileOutputStream fout = new FileOutputStream(renameFile);
				
				while((read = fin.read(bt, 0, bt.length)) != -1){
					fout.write(bt, 0, read);
				}
				
				fin.close();
				fout.close();
				originFile.delete();
			}
			
			String imgUrl = request.getContextPath() + "/resources/images/lab/cachUploadImages/" + renameFileName;
			mv.addObject("imgUrl", imgUrl);
		}
		
		mv.setViewName("jsonView");
		
		
		return mv;
	}
	
	// 수정페이지 이동
	@RequestMapping("LabUpdate")
	public ModelAndView moveUpdateLab(@RequestParam(value="no") int no, ModelAndView mv){
		mv.addObject("pageSubType", "Lab");
		
		mv.addObject("Lab", labService.selectLabDetail(no));
		mv.setViewName("client/lab/labUpdate");	
		
		return mv;
	}
	


	
	// 연구소 글 수정
	@RequestMapping(value="updateLab", method= RequestMethod.POST)
	public ModelAndView updateLab(ModelAndView mv, HttpServletRequest request, LabDto lab, @RequestParam(value="imgListArr", required=false) String imgListArr) throws Exception{
		JSONParser jsonParser = new JSONParser();
		ArrayList<String> imgList = (ArrayList<String>)jsonParser.parse(imgListArr);
		String resultMessage = "fail";
		
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("loginMemberDto");
		lab.setId(memberDto.getId());
		
		if(imgList != null){
			String resourcesPath = request.getSession().getServletContext().getRealPath("resources");
			resourcesPath = resourcesPath.replaceAll("resources", "");
			
			File fileDirectory = new File(resourcesPath + "/resources/images/lab/successImages");
			
			if(!fileDirectory.exists()){
				fileDirectory.mkdirs();
			}
			
			String contentTag = lab.getContent_tag();
			
			for(int i = 0 ; i < imgList.size(); i++){
				File cachFile = new File(resourcesPath + imgList.get(i));
				String realFileSrc = imgList.get(i).replaceAll("cachUploadImages", "successImages");
				File realFile = new File(resourcesPath + realFileSrc);
				
				
				if(!cachFile.renameTo(realFile)){
					int read = -1;
					byte[] bt = new byte[1024];
					
					FileInputStream fin = new FileInputStream(cachFile);
					FileOutputStream fout = new FileOutputStream(realFile);
					
					while((read = fin.read(bt, 0, bt.length)) != -1){
						fout.write(bt, 0, read);
						
					}
					
					fin.close();
					fout.close();
					cachFile.delete();
				}
				
				contentTag = contentTag.replaceAll(imgList.get(i), realFileSrc);
				
				if(i == 0){
					lab.setThumbnail(realFileSrc);
					
				}
			}
			
			lab.setContent_tag(contentTag);
			
			File temporaryFile = new File(resourcesPath + "/resources/images/lab/cachUploadImages");
			
			if(temporaryFile.exists()){
				File[] deleteFolderList = temporaryFile.listFiles();
				
				for(int j = 0 ; j < deleteFolderList.length; j++){
					deleteFolderList[j].delete();
				}
				
				if(deleteFolderList.length == 0 && temporaryFile.isDirectory()){
					temporaryFile.delete();
					
				}
			}
		}
		
		if(labService.updateLab(lab) > 0){
			resultMessage = "success";
		}
		
		mv.addObject("resultMessage", resultMessage);
		mv.setViewName("jsonView");
		
		
		return mv;
	}
	
	// 연구소 글 삭제
	@RequestMapping("deleteLab")
	public ModelAndView deleteLab(ModelAndView mv, @RequestParam(value="no") int no){
		String result = "fail";
		
		if(labService.deleteLab(no) > 0) {
				result = "ok"; 
		}
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		
		return mv;
	}
		
	// 연구소 글 검색
	public ModelAndView selectSearchLab(ModelAndView mv){
			
		return mv;
	}
		
		
	
	/*// 연구소 게시글 총 갯수
	public ModelAndView selectCountLab(ModelAndView mv){
			
		return mv;
	}*/
	
	// 연구소 검색 결과 갯수
	public ModelAndView selectCountSearchLab(ModelAndView mv){
		
		return mv;
	}
	
	
	
	
	
	
}
