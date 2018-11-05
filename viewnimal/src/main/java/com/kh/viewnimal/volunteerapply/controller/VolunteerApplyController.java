package com.kh.viewnimal.volunteerapply.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.member.model.dto.MemberDto;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplierDto;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplyDto;
import com.kh.viewnimal.volunteerapply.model.service.VolunteerApplyService;


@Controller
public class VolunteerApplyController {
	
	@Autowired
	private VolunteerApplyService volunteerApplyService;
	
	//자원봉사 모집글 검색 카테고리 목록(년,월) 불러오기
	@RequestMapping("VolunteerApplyWrite")
	public ModelAndView selectVolunteerApplyCategoryList(ModelAndView mav){
		mav.setViewName("client/volunteerapply/volunteerApplyWrite");
		mav.addObject("pageSubType", "VolunteerApplyList");
		
		return mav;
	}
	
	//자원봉사 모집 리스트 페이지로 이동
	@RequestMapping(value="VolunteerApplyList", method=RequestMethod.GET)
	public ModelAndView VolunteerApplyList(ModelAndView mav){
		
		mav.setViewName("client/volunteerapply/volunteerApplyList");
		mav.addObject("pageSubType", "VolunteerApplyList");
		return mav;
	}
	
	//자원봉사 모집글 리스트(특정 한달치만) 불러오기
	@RequestMapping(value="selectVolunteerApplyList", method=RequestMethod.POST)
	public ModelAndView selectVolunteerApplyList(ModelAndView mav, @RequestParam("selectedmonth")String selectedMonth){
		
		ArrayList<VolunteerApplyDto> volunteerApplyDtoList = volunteerApplyService.selectSearchVolunteerApplyList(selectedMonth);
		
		if(volunteerApplyDtoList != null && volunteerApplyDtoList.size() > 0){
			for(int i=0; i < volunteerApplyDtoList.size(); i++){
				//글 클릭했을 때 해당 글 디테일 뷰 url 
				volunteerApplyDtoList.get(i).setUrl("/VolunteerApplyDetail?volunteer_date=" + volunteerApplyDtoList.get(i).getVolunteer_date());
				
				if(volunteerApplyDtoList.get(i).getThumbnail() == null){			
					volunteerApplyDtoList.get(i).setThumbnail("/resources/common/images/main_logo.png"); //썸네일 사진 없을때 디폴트 이미지(나중에 바꿈)
				}		
			}			
			mav.addObject("monthly", volunteerApplyDtoList);
		}
		
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	//서머노트 이미지 파일 즉시 업로드
	@RequestMapping(value="volunteerApplyfileupload", method=RequestMethod.POST)
	public ModelAndView testFileUpload(HttpServletRequest request, ModelAndView mav, @RequestParam(name="file") MultipartFile file) throws Exception{
		/*System.out.println("sample : " + sample);
		System.out.println("file : " + file.getOriginalFilename());*/
		
		//파일 저장 폴더 지정하기(임시 저장소 경로)
		String savePath = request.getSession().getServletContext().getRealPath("resources/images/volunteerapply/cachUploadImages");	
			
		/*file.transferTo(new File(savePath + "\\" + 
				file.getOriginalFilename()));*/
		
		//파일명을 'yyyyMMddhhmmss.확장자' 로 변경함
		//변경된 파일명이 폴더에 저장되게 함
		
		String originalFileName = file.getOriginalFilename();
		String renameFileName = null;
		
		if(originalFileName != null){
			File fileDirectory = new File(savePath);
	        //해당 경로의 폴더가 없으면
	        if(!fileDirectory.exists()){
	            //폴더 생성 메서드
	        	fileDirectory.mkdirs();
	        }
	        
	      
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "_" + ((int)(Math.random()*100000)+1) + "." + originalFileName.substring(
							 originalFileName.lastIndexOf(".") + 1);
			//System.out.println("rename : " + renameFileName);
			
			//전송받은 파일 객체를 지정 폴더에 저장함
			file.transferTo(new File(savePath + "//" + file.getOriginalFilename()));				
			
			//파일명 바꾸려면 File 객체의 renameTo() 사용함
			File originFile = 
				new File(savePath + "//" + originalFileName);
			File renameFile = 
				new File(savePath + "//" + renameFileName);
			
			//파일 이름바꾸기 실행 >> 실패할 경우 직접 바꾸기함
			//새 파일만들고 원래 파일 내용 읽어서 복사하고
			//복사가 끝나면 원래 파일 삭제함
			if(!originFile.renameTo(renameFile)){
				int read = -1;
				byte[] buf = new byte[1024];
				
				FileInputStream fin = 
					new FileInputStream(originFile);
				FileOutputStream fout =
					new FileOutputStream(renameFile);
				
				while((read = fin.read(buf, 0, buf.length)) != -1){
					fout.write(buf, 0, read);
				}
				
				fin.close();
				fout.close();	
				originFile.delete();
			}
			
			String imgUrl = request.getContextPath() + "/resources/images/volunteerapply/cachUploadImages/" + renameFileName;
			mav.addObject("imgUrl", imgUrl);
		}
		
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	//자원봉사 모집글 등록하기
	@RequestMapping(value="insertVolunteerApply", method=RequestMethod.POST)
	public ModelAndView insertVolunteerApply(HttpServletRequest request, ModelAndView mav, VolunteerApplyDto volunteerApply, @RequestParam(value="imgListArr", required=false) String imgListArr) throws Exception{
		
		mav.setViewName("jsonView");
		JSONParser jsonParser = new JSONParser();
		ArrayList<String> imgList = (ArrayList<String>)jsonParser.parse(imgListArr);
		
		String resultMessage = "fail";
		
		String contentTag = volunteerApply.getContent_tag();
		
		//세션에서 현재 아이디 값 가져오기
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}
	
		volunteerApply.setId(loginDto.getId()); 
		
		//뷰에서 가져온  src 의 임시경로를 실제 경로로 변환 작업
		if ( imgList.size() > 0){
			String resourcesPath = request.getSession().getServletContext().getRealPath("resources");
			resourcesPath = resourcesPath.replaceAll("resources", "");
			System.out.println(resourcesPath + "/resources/images/volunteerapply/realUploadImages");
			File fileDirectory = new File(resourcesPath + "/resources/images/volunteerapply/realUploadImages");
	        //해당 경로의 폴더가 없으면
	        if(!fileDirectory.exists()){
	            //폴더 생성 메서드
	        	fileDirectory.mkdirs();
	        }
					
			for(int i = 0; i < imgList.size(); i ++) {
				//파일명 바꾸려면 File 객체의 renameTo() 사용함
				File cachFile = new File(resourcesPath + imgList.get(i));
				
				
				String realFileSrc = imgList.get(i).replaceAll("cachUploadImages", "realUploadImages");
				File realFile = new File(resourcesPath + realFileSrc);
				//File realFile = new File(path + "/" + realFileSrc);
				
				
				//파일 이름바꾸기 실행 >> 실패할 경우 직접 바꾸기함
				//새 파일만들고 원래 파일 내용 읽어서 복사하고
				//복사가 끝나면 원래 파일 삭제함
				
				if(!realFile.exists() && !cachFile.renameTo(realFile)){
					int read = -1;
					byte[] buf = new byte[1024];
					
					FileInputStream fin = 
						new FileInputStream(cachFile);
					FileOutputStream fout =
						new FileOutputStream(realFile);
					
					while((read = fin.read(buf, 0, buf.length)) != -1){
						fout.write(buf, 0, read);
					}
					
					fin.close();
					fout.close();	
					
					cachFile.delete();
				}
					
				//contentTag안의 img 태그의 src 속성 안의 임시 저장경로를 실제 저장 경로로 변환		
				contentTag = contentTag.replaceAll(imgList.get(i), realFileSrc);
				//맨첫번째 사진을 썸네일로 저장
				if(i == 0){
					volunteerApply.setThumbnail(realFileSrc);
				}
			}
			
			//임시파일폴더 지우기
			File cachPathDriectory = new File(resourcesPath + "/resources/images/volunteerapply/cachUploadImages");
			
			if(cachPathDriectory.exists()){
				File[] deleteFolderList = cachPathDriectory.listFiles();
				
				for (int j = 0; j < deleteFolderList.length; j++) {
					deleteFolderList[j].delete(); 
				}
	
				if(deleteFolderList.length == 0 && cachPathDriectory.isDirectory()){
					cachPathDriectory.delete();
				}
			}		
		}
		
		//변환한 태그내용을 저장			
		volunteerApply.setContent_tag(contentTag.replaceAll(System.getProperty("line.separator"), ""));//줄바꿈 공백 지우기
		
		volunteerApply.setTitle(volunteerApply.getTitle().replaceAll("\"", "")); //html 태그 값에 넣을때 "가 있으면 값의 끝을 의미하기 때문에 넣을때 " 지우고
		volunteerApply.setVolunteer_area(volunteerApply.getVolunteer_area().replaceAll("\"", ""));
		
		if(volunteerApplyService.insertVolunteerApply(volunteerApply) > 0){
			resultMessage = "success";
		}
		
		mav.addObject("resultMessage", resultMessage);
	
		return mav;
	}
	
	//자원봉사 모집 상세글 불러오기
	@RequestMapping("VolunteerApplyDetail")
	public ModelAndView selectVolunteerApply(ModelAndView mav, @RequestParam("volunteer_date")String volunteer_date){
		
		mav.addObject("pageSubType", "VolunteerApplyList");
		
		VolunteerApplyDto volunteerApplyDto = volunteerApplyService.selectVolunteerApply(volunteer_date);	
		
		if(volunteerApplyDto == null){
			//에러 페이지 뷰 이름 설정
		}
		else{
			mav.addObject("volunteerApplyDto", volunteerApplyDto);
			mav.setViewName("client/volunteerapply/volunteerApplyDetail");
		}
		
		
		return mav;
	}
	
	//자원봉사 모집 상세글 수정 페이지 이동
	@RequestMapping(value="VolunteerApplyModify",method=RequestMethod.GET)
	public ModelAndView volunteerApplyModify(ModelAndView mav, @RequestParam(value="volunteer_date")String volunteer_date){	
		
		mav.addObject("pageSubType", "VolunteerApplyList");
		
		VolunteerApplyDto volunteerApply = volunteerApplyService.selectVolunteerApply(volunteer_date);
		
		if(volunteerApply == null){
			
		}
		
	    //volunteerApply.setContent_tag(volunteerApply.getContent_tag().replaceAll("'", "\\\\'")); //서머노트 코드는 html에 바로 값을 넣는게 아니라 자바스크립트안에서 함수를 통해 넣는것이기 때문에 자바문자열 표시인 ''를 신경써야한다
		
		mav.addObject("volunteerApply", volunteerApply);
		
		mav.setViewName("client/volunteerapply/volunteerApplyModify");
		
		return mav;
	}
	
	//자원봉사 수정 데이터 update
	@RequestMapping(value="updateVolunteerApply", method=RequestMethod.POST)
	public ModelAndView updateVolunteerApply(ModelAndView mav, HttpServletRequest request, VolunteerApplyDto volunteerApply,
	@RequestParam(value="imgList",required=false)ArrayList<String> imgList) 
	throws Exception{
		
		mav.setViewName("jsonView");
		String resultMessage = "fail";
		int insertImgCount = volunteerApply.getInsertImgCount();
		//세션에서 현재 아이디 값 가져오기
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}

		volunteerApply.setId(loginDto.getId()); 
		
		//뷰에서 가져온  src 의 임시경로를 실제 경로로 변환 작업
		String resourcesPath = request.getSession().getServletContext().getRealPath("resources");
		resourcesPath = resourcesPath.replaceAll("resources", "");
		String contentTag = volunteerApply.getContent_tag();
		
		if (insertImgCount > 0){		
			File fileDirectory = new File(resourcesPath + "/resources/images/volunteerapply/realUploadImages");
	        //해당 경로의 폴더가 없으면
	        if(!fileDirectory.exists()){
	            //폴더 생성 메서드
	        	fileDirectory.mkdirs();
	        }
					
			for(int i = 0; i < insertImgCount; i ++) {
				//파일명 바꾸려면 File 객체의 renameTo() 사용함
				File cachFile = new File(resourcesPath + imgList.get(i));
				String realFileSrc = imgList.get(i).replaceAll("cachUploadImages", "realUploadImages");
				File realFile = new File(resourcesPath + realFileSrc);
				//File realFile = new File(path + "/" + realFileSrc);
				

				//파일 이름바꾸기 실행 >> 실패할 경우 직접 바꾸기함
				//새 파일만들고 원래 파일 내용 읽어서 복사하고
				//복사가 끝나면 원래 파일 삭제함
				
				if(!realFile.exists() && !cachFile.renameTo(realFile)){
					int read = -1;
					byte[] buf = new byte[1024];
					
					FileInputStream fin = 
						new FileInputStream(cachFile);
					FileOutputStream fout =
						new FileOutputStream(realFile);
					
					while((read = fin.read(buf, 0, buf.length)) != -1){
						fout.write(buf, 0, read);
					}
					
					fin.close();
					fout.close();	
					
					cachFile.delete();
				}
	
				//contentTag안의 img 태그의 src 속성 안의 임시 저장경로를 실제 저장 경로로 변환		
				contentTag = contentTag.replaceAll(imgList.get(i), realFileSrc);
			}
				
			//임시파일폴더 지우기
			File cachPathDriectory = new File(resourcesPath + "/resources/images/volunteerapply/cachUploadImages");
			
			if(cachPathDriectory.exists()){
				File[] deleteFolderList = cachPathDriectory.listFiles();
				
				for (int j = 0; j < deleteFolderList.length; j++) {
					deleteFolderList[j].delete(); 
				}
	
				if(deleteFolderList.length == 0 && cachPathDriectory.isDirectory()){
					cachPathDriectory.delete();
				}
			}
	
		}
		
		//수정전에 이미지가 없었거나 지운 이미지가 있으면
		if(insertImgCount < imgList.size()){ //imglist 사이즈가 더 커야 뒤에 지워야 할 데이터가 있으니
			for(int i=insertImgCount; i< imgList.size(); i++){
				File removeFile = new File(resourcesPath + imgList.get(i));
				if(removeFile.exists()){
					removeFile.delete();
				}
			}
		}
		
		//첫번째 이미지 썸네일로 저장(직접 컨텐트태그에서 자름) - 썸네일이 바뀌지않는 경우 .contain()메소드 비교후 쓸수 있지만 쓰는것 자체가 한번 더 비교
		//클라이언트쪽에선 가능
		String imgSrcPath = "/resources/images/volunteerapply/realUploadImages";
		if(contentTag.contains(imgSrcPath)){		
			int firstIndex = contentTag.indexOf(imgSrcPath);
			String newThumbnail = contentTag.substring(firstIndex, contentTag.indexOf("\"", firstIndex + imgSrcPath.length()));
			volunteerApply.setThumbnail(newThumbnail);
		}
		
		//변환한 태그내용을 저장			
		volunteerApply.setContent_tag(contentTag.replaceAll(System.getProperty("line.separator"), ""));//줄바꿈 공백 지우기
		
		if(volunteerApplyService.updateVolunteerApply(volunteerApply) > 0){
			resultMessage = "success";
		}
		
		mav.addObject("resultMessage", resultMessage);
	
		return mav;
	}
	
	//자원봉사 신청자 목록 불러오기
	@RequestMapping(value="selectVolunteerApplierList", method=RequestMethod.POST)
	public ModelAndView selectVolunteerApplierList(ModelAndView mav, VolunteerApplierDto pageDto){
		
		mav.setViewName("jsonView");
		
		int countList = 5;//한페이지에 보일 게시글 갯수
		pageDto.setCount_list(5);
		
		//신청자 수 
		int applier_count = pageDto.getApplier_count();
		
		int countPage = 5;	//한페이지에 보일 페이지네이션 총 페이지 수			
		int maxPage = applier_count / countList;
		int currentPage = pageDto.getCurrent_page();
		
		if(applier_count % countList > 0){
			maxPage++;
		}
			
		if(maxPage < currentPage){
			currentPage = maxPage;
		}
		
	
		int start_row = (currentPage - 1)  * countList +1;
		int end_row = start_row + countList - 1;
		
		pageDto.setStart_row(start_row);
		pageDto.setEnd_row(end_row);
		
		ArrayList<VolunteerApplierDto> list = volunteerApplyService.selectVolunteerApplierList(pageDto);
		//보드 리스트들
		mav.addObject("list", list);
		
		int startPage = ((currentPage - 1) / countPage) * countPage + 1;
		int endPage = startPage + countPage - 1;
		
		if(endPage > maxPage){
			endPage = maxPage;
		}
		
		HashMap<String, Integer> pageMap = new HashMap<>();
		pageMap.put("max_page", maxPage);
		pageMap.put("start_page", startPage);
		pageMap.put("end_page", endPage);
		pageMap.put("current_page", currentPage);
		System.out.println("max: " + maxPage + "start_page:" + startPage + "end_page:" + endPage + "current_page:" + currentPage);
		//페이지에 대한 정보들
		mav.addObject("infoMap", pageMap);
			
		return mav;
	}
	
	@RequestMapping(value="selectCheckVolunteerApply", method=RequestMethod.POST)
	public ModelAndView selectCheckVolunteerApply(ModelAndView mav, @RequestParam("volunteer_date")String volunteer_date, HttpServletRequest request){
		
		mav.setViewName("jsonView");
		//세션에서 현재 아이디 값 가져오기
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}
	
		HashMap<String, String> map = new HashMap<>();
		
		map.put("id", loginDto.getId());
		map.put("volunteer_date", volunteer_date);
		
		int result = volunteerApplyService.selectCheckVolunteerApply(map);
		
		mav.addObject("checkApply", result);		
		
		return mav;
	}
	//자원봉사 신청하기
	@RequestMapping(value="insertApplyVolunteer", method=RequestMethod.POST)
	public ModelAndView insertApplyVolunteer(ModelAndView mav, @RequestParam("volunteer_date")String volunteer_date, HttpServletRequest request){
		
		mav.setViewName("jsonView");			
		HashMap<String, String> map = new HashMap<>();
		
		//세션에서 현재 아이디 값 가져오기
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}
	
		map.put("id", loginDto.getId());
		map.put("volunteerDate", volunteer_date);
		
		HashMap resultMap = volunteerApplyService.insertApplyVolunteer(map);
		
		mav.addObject("resultValue", resultMap.get("returnResult"));
		
		return mav;
	}
	//자원봉사 취소하기
	@RequestMapping(value="deleteApplyVolunteer", method=RequestMethod.POST)
	public ModelAndView deleteApplyVolunteer(ModelAndView mav, @RequestParam("volunteer_date")String volunteer_date, HttpServletRequest request){
		
		mav.setViewName("jsonView");
		mav.addObject("result", "fail");
		//세션에서 현재 아이디 값 가져오기
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}
		
		HashMap<String, String> map = new HashMap<>();
		map.put("volunteer_date", volunteer_date);
		map.put("id", loginDto.getId());
		
		if(volunteerApplyService.deleteApplyVolunteer(map) > 0){
			mav.addObject("result", "success");
		}
		
		return mav;
	}

}
