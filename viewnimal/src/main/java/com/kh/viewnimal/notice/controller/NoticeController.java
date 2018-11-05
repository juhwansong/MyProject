package com.kh.viewnimal.notice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.notice.model.dto.NoticeDto;
import com.kh.viewnimal.notice.model.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	//공지사항 목록 페이지로 이동 / 검색
	@RequestMapping(value = "NoticeList", method = RequestMethod.GET)
	public ModelAndView moveNoticeListPage( ModelAndView mv, HttpServletRequest request, HashMap<String, Object> paging ){
		
		int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
		int countList = (request.getParameter("cl") != null) ? Integer.parseInt(request.getParameter("cl")) : 10;
		
		//페이지네이션
		HashMap<String, Integer> map = null;
		
		//검색 목록 출력
		if(request.getParameter("c") != null){
			paging.put("category",	request.getParameter("c"));
			paging.put("keyword",	request.getParameter("k"));
			paging.put("countList", countList);		//목록 개수 >> 페이지 변화 후 고정시킬 목적
			
			map = pagination(currentPage, noticeService.selectCountSearch(paging), countList);
			
			paging.put("startrow", map.get("startrow"));
			paging.put("endrow", map.get("endrow"));
			
			mv.addObject("list", noticeService.selectSearchNotice(paging));
			
		//기본 목록 출력
		}else{
			map = pagination(currentPage, noticeService.selectCountList(), countList);
			
			paging.put("startrow", map.get("startrow"));
			paging.put("endrow", map.get("endrow"));
			
			mv.addObject("list", noticeService.selectNoticeList(paging));
		}
		
		mv.addObject("pageSubType", "NoticeList");
		mv.addAllObjects(map);
		mv.setViewName("client/notice/noticeList");
		
		return mv;
	}	
	
	
	//공지사항 작성 페이지로 이동
	@RequestMapping(value = "NoticeWrite", method = RequestMethod.GET)
	public ModelAndView moveNoticeWritePage(ModelAndView mv){
		mv.addObject("pageSubType", "NoticeList");
		mv.setViewName("client/notice/noticeWrite");
		return mv;
	}
	
	
	//공지사항 상세보기로 이동
	@RequestMapping(value = "NoticeDetail", method = RequestMethod.GET)
	public ModelAndView moveNoticeDetailPage(ModelAndView mv, HashMap<String, String[]> file, NoticeDto notice, @RequestParam(value="no") int no){		
		mv.addObject("pageSubType", "NoticeList");
		
		noticeService.updateAddReadCount(no);	//조회수 증가
		notice = noticeService.selectNotice(no);//공지사항조회
		
		//첨부 파일 목록 처리용
		if(notice.getOriginal_file_name() != null){
			String[] ofn = notice.getOriginal_file_name().split(", ");
			String[] rfn = notice.getRename_file_name().split(", ");
			file.put("orifile", ofn);
			file.put("refile", rfn);
			mv.addAllObjects(file);
		}
		mv.addObject("notice", notice);
		mv.setViewName("client/notice/noticeDetail");
		return mv;
	}
	
	
	//공지사항 수정 페이지로 이동
	@RequestMapping(value = "NoticeModify", method = RequestMethod.GET)
	public ModelAndView moveNoticeModifyPage(ModelAndView mv, @RequestParam(value="no") int no, HashMap<String, String[]> file, NoticeDto notice){
		mv.addObject("pageSubType", "NoticeList");
		notice = noticeService.selectNotice(no); //공지사항조회
		
		//기존 파일 삭제목록 처리용
		if(notice.getOriginal_file_name() != null){
			String[] ofn = notice.getOriginal_file_name().split(", ");
			file.put("orifile", ofn);
			mv.addAllObjects(file);
		}
		mv.addObject("notice", notice);
		mv.setViewName("client/notice/noticeModify");
		return mv;
	}
	
	
	//공지사항 작성
	@RequestMapping(value = "noticeWrite", method = RequestMethod.POST)
	public String insertNotice(NoticeDto notice){		
		noticeService.insertNotice(notice);
		return "redirect:/NoticeList";
	}
	
	
	//공지사항 수정(수정 완료 후 상세보기, 조회수증가X)
	@RequestMapping(value = "noticeModify", method = RequestMethod.POST)
	public ModelAndView updateNotice(NoticeDto notice, ModelAndView mv, HttpServletRequest request){
		
		//삭제할 파일이 있을 시
		if(request.getParameter("deleteRenameFiles") != null){
			String[] deleteFiles = request.getParameter("deleteRenameFiles").split(",");
			
			String savePath = request.getSession().getServletContext().getRealPath("resources/images/notice");
			
			//디렉토리에서 파일 삭제
			for(String deleteFile : deleteFiles){
				File renameFile = new File(savePath + "/" + deleteFile);
				renameFile.delete();
			}//for each close
		}//if close
		
		noticeService.updateNotice(notice);
		mv.addObject("pageSubType", "NoticeList");
		mv.addObject("notice", noticeService.selectNotice(notice.getNo()));
		mv.setViewName("client/notice/noticeDetail");
		return mv;
	}
	
	
	//공지사항 삭제(삭제 완료 후 목록으로 이동)
	@RequestMapping(value = "noticeDelete", method = RequestMethod.POST)
	public String deleteNotice(@RequestParam(value="no") int no){
		noticeService.deleteNotice(no);
		return "redirect:/NoticeList";
	}		
	
	
	//파일업로드
	@RequestMapping(value = "multifileup", method = RequestMethod.POST)
	public ModelAndView MultiFileUploadMethod(@RequestParam(value="fileList", required=true) ArrayList<MultipartFile> fileList, 
			MultipartHttpServletRequest request, ModelAndView mv) {
		
		String savePath = request.getSession().getServletContext().getRealPath("resources/images/notice");
		
		String[] ofn = new String[fileList.size()];
		String[] rfn = new String[fileList.size()];
		
		for(int i = 0; i < fileList.size(); i++){
			String originalFileName = fileList.get(i).getOriginalFilename();
			String renameFileName = null;

			try {
				
				if (originalFileName != null) {
					renameFileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new java.sql.Date(System.currentTimeMillis()))
							+ i + "." + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
					
					fileList.get(i).transferTo(new File(savePath + "/" + fileList.get(i).getOriginalFilename()));

					File originFile = new File(savePath + "/" + originalFileName);
					File renameFile = new File(savePath + "/" + renameFileName);

					if (!originFile.renameTo(renameFile)) {
						int read = -1;
						byte[] buf = new byte[1024];

						FileInputStream fin = new FileInputStream(originFile);
						FileOutputStream fout = new FileOutputStream(renameFile);

						while ((read = fin.read(buf, 0, buf.length)) != -1) {
							fout.write(buf, 0, read);
						}

						fin.close();
						fout.close();
						originFile.delete();
					}
				}
				
				ofn[i] = originalFileName;
				rfn[i] = renameFileName;
				
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}//for each close

		Map<String, String> map = new HashMap<>();		
		map.put("ofn", Arrays.toString(ofn).substring(1, Arrays.toString(ofn).length() - 1));	//괄호 제거
		map.put("rfn", Arrays.toString(rfn).substring(1, Arrays.toString(rfn).length() - 1));	//괄호 제거
		mv.addAllObjects(map);
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	//파일다운로드
	@RequestMapping(value = "mfdown", method = RequestMethod.GET)
	public ModelAndView fileDownload(ModelAndView mv, HttpServletRequest request,
			@RequestParam("ofile") String originalFileName, @RequestParam(name = "rfile") String renameFileName){

		File readFile = new File(request.getSession().getServletContext().getRealPath("resources/images/notice") + "/" + renameFileName);
		File originFile = new File(originalFileName);

		mv.addObject("readFile", readFile);
		mv.addObject("downFile", originFile);
		mv.setViewName("filedown");
		return mv;
	}
	
	
	//페이지네이션
	public HashMap<String, Integer> pagination(int page, int total, int list){
		HashMap<String, Integer> paging = new HashMap<>();
		int countList = list, countPage = 5, currentPage = page, totalCount = total; //목록개수, 페이지개수, 현재페이지, 전체게시물개수
		int maxPage = totalCount / countList;
		
		if(totalCount % countList > 0)
			maxPage++;
		
		currentPage = (maxPage < currentPage) ? maxPage : currentPage;
		
		int startPage = ((currentPage - 1) / countPage) * countPage + 1;
		int endPage = startPage + countPage - 1;
		
		endPage = (endPage > maxPage) ? maxPage : endPage;
		
		int startrow = (currentPage - 1) * countList + 1;
		int endrow = startrow + countList - 1;
		
		paging.put("currentPage", currentPage);	//현재 페이지
		paging.put("maxPage", maxPage);			//끝 페이지
		paging.put("startPage", startPage);		//첫 페이지
		paging.put("endPage", endPage);			//페이지 개수 중 마지막
		paging.put("startrow", startrow);		//출력될 게시물 시작 번호
		paging.put("endrow", endrow);			//출력될 게시물 끝 번호
		
		return paging;
	}

}
