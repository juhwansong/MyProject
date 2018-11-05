package com.kh.viewnimal.volunteerepilogue.controller;

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
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueDto;
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueReplyDto;
import com.kh.viewnimal.volunteerepilogue.model.service.VolunteerEpilogueService;

@Controller
public class VolunteerEpilogueController {
	@Autowired
	private VolunteerEpilogueService volunteerEpilogueService;
	
	//자원봉사 후기 글 검색 카테고리 목록(년,월,일) 불러오기
	@RequestMapping(value="selectVolunteerEpilogueCategoryList", method=RequestMethod.POST)
	public ModelAndView selectVolunteerEpilogueCategoryList(ModelAndView mav, HttpServletRequest request){
		String categoryKeword = request.getParameter("categoryKeword");
		ArrayList<String> categoryList = volunteerEpilogueService.selectVolunteerEpilogueCategoryList(categoryKeword);
		mav.addObject("categoryList", categoryList);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	//자원봉사 후기 목록 페이지로 이동
	@RequestMapping("VolunteerEpilogueList")
	public ModelAndView volunteerEpilogueList(ModelAndView mav){
		//자원봉사 후기 글 갯수 가져오는것도 이안에서 처리
		mav.setViewName("client/volunteerepilogue/volunteerEpilogueList");
		mav.addObject("pageSubType", "VolunteerEpilogueList");
		return mav;
	}
	
	//자원봉사 후기 상세글
	@RequestMapping("VolunteerEpilogueDetail")
	public ModelAndView updateVolunteerApply(ModelAndView mav, VolunteerEpilogueDto volunteerEpilogueAjaxData){
		mav.setViewName("client/volunteerepilogue/volunteerEpilogueDetail");
		mav.addObject("pageSubType", "VolunteerEpilogueList");
		
		//조회수 증가
		volunteerEpilogueService.updateAddReadCountVolunteerEpilogue(volunteerEpilogueAjaxData.getNo());
		//상세글 불러오기
		VolunteerEpilogueDto volunteerEpilogueDetailData = volunteerEpilogueService.selectVolunteerEpilogue(volunteerEpilogueAjaxData.getNo());
		
		if(volunteerEpilogueDetailData != null){// 선택한 게시글 정보를 찾을 수 없으면
			
		}
			
		volunteerEpilogueDetailData.setCurrent_page(volunteerEpilogueAjaxData.getCurrent_page());
		volunteerEpilogueDetailData.setDate_keword(volunteerEpilogueAjaxData.getDate_keword());
		volunteerEpilogueDetailData.setMyboard_search(volunteerEpilogueAjaxData.getMyboard_search()); 
		
		mav.addObject("volunteerEpilogueDetailData", volunteerEpilogueDetailData);
		
		mav.setViewName("client/volunteerepilogue/volunteerEpilogueDetail");
		
		return mav;
	}
	
	//자원봉사 후기 작성 페이지로 이동
	@RequestMapping("VolunteerEpilogueWrite")
	public ModelAndView moveVolunteerEpiloguePage(ModelAndView mav, HttpServletRequest request){
		mav.setViewName("client/volunteerepilogue/volunteerEpilogueWrite");
		mav.addObject("pageSubType", "VolunteerEpilogueList");
				
		return mav;
	}
	
	//자원봉사 쓰기 글 버튼 눌렀을 때 쓸 수 있는 글이 있는지 없는지 상태값 반환
	@RequestMapping(value="selectVolunteerEpiloguePossibleState", method=RequestMethod.POST)
	public ModelAndView selectVolunteerEpiloguePossibleState(ModelAndView mav, HttpServletRequest request){
		
		mav.setViewName("jsonView");
		mav.addObject("resultMessage", "로그인하셔야 합니다.");
		//예외처리 부분	
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		
		if(loginDto == null){		
			//예외처리
			return mav;
		}
		
		String userId = loginDto.getId();	
		ArrayList<VolunteerApplierDto> volunteerApplyList = volunteerEpilogueService.selectVolunteerEpiloguePossibleState(userId);
		
		if(volunteerApplyList == null || volunteerApplyList.size() < 1){
			mav.addObject("resultMessage", "참여하신 자원봉사가 없습니다.!");
			return mav; //결과 메세지 갖고 돌아감
		}
		
		for(VolunteerApplierDto volunteerApplyState : volunteerApplyList){
			if(volunteerApplyState.getEpilogue_write_state().equals("N")){
				mav.addObject("resultMessage", "success");
				return mav; //결과 메세지 갖고 돌아감
			}
		}
		
		mav.addObject("resultMessage", "이미 작성하신 후기가 있습니다!\n수정을 원하시면 내가 쓴 글 보기를 통해 수정해주세요!");
	
		
		return mav;
	}
	
	//작성 가능 한 카테고리 목록 가져옴
	@RequestMapping(value="selectVolunteerEpilogueWriteCategoryList", method=RequestMethod.POST)
	public ModelAndView selectVolunteerEpilogueWriteCategoryList(ModelAndView mav, HttpServletRequest request){
		mav.setViewName("jsonView");
		
		//예외처리 부분
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}
		
		ArrayList<VolunteerEpilogueDto> categoryList = volunteerEpilogueService.selectVolunteerEpilogueWriteCategoryList(loginDto.getId());
			
		mav.addObject("categoryList", categoryList);
		
		return mav;
	}
	
	//자원봉사 후기 검색 결과 목록 불러오기  
	@RequestMapping(value="selectSearchVolunteerEpilogue", method=RequestMethod.POST)
	public ModelAndView selectSearchVolunteerEpilogue(ModelAndView mav, VolunteerEpilogueDto keywordDto, HttpServletRequest request){
		mav.setViewName("jsonView");
		
		int countList = 6;//한페이지에 보일 게시글 갯수
		keywordDto.setCount_list(6);
		
		if(keywordDto.getMyboard_search() != null && keywordDto.getMyboard_search().equals("active")){
			//예외처리 부분
			MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
			if(loginDto == null){		
				//예외처리
			}
			keywordDto.setId(loginDto.getId());
		}
		
		//자원봉사 후기 검색 결과 목록 글 갯수 가져오기
		int boardCount = volunteerEpilogueService.selectCountSearchVolunteerEpilogueList(keywordDto);
		
		int countPage = 10;	//한페이지에 보일 페이지네이션 총 페이지 수			
		int maxPage = boardCount / countList;
		int currentPage = keywordDto.getCurrent_page();
		
		if(boardCount % countList > 0){
			maxPage++;
		}
			
		if(maxPage < currentPage){
			currentPage = maxPage;
		}
		
	
		int start_row = (currentPage - 1)  * countList +1;
		int end_row = start_row + countList - 1;
		
		keywordDto.setStart_row(start_row);
		keywordDto.setEnd_row(end_row);
	
		ArrayList<VolunteerEpilogueDto> list = volunteerEpilogueService.selectSearchVolunteerEpilogue(keywordDto);
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
		
		//페이지, 키워드에 대한 정보들
		mav.addObject("infoMap", pageMap);
		//mav.addObject("volunteerEpilogueList", );
		
		return mav;
	}
	
	//자원봉사 후기 글 등록하기
	@RequestMapping(value="insertVolunteerEpilogue", method=RequestMethod.POST)
	public ModelAndView insertVolunteerEpilogue(HttpServletRequest request, ModelAndView mav, VolunteerEpilogueDto volunteerEpilogue, @RequestParam(value="imgListArr", required=false) String imgListArr, @RequestParam(name="thumbnailfile") MultipartFile thumbnailFile) throws Exception{
		
		mav.setViewName("jsonView");
		JSONParser jsonParser = new JSONParser();	
		ArrayList<String> imgList = (ArrayList<String>)jsonParser.parse(imgListArr);
		String resultMessage = "fail";
		
		//세션에서 현재 아이디 값 가져오기
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}

		volunteerEpilogue.setId(loginDto.getId()); 
		String contentTag = volunteerEpilogue.getContent_tag();
		
		////////////////////////////////////////////////////////////////
		//썸네일 저장 폴더 지정하기
		String resourcesPath = request.getSession().getServletContext().getRealPath("resources");
		resourcesPath = resourcesPath.replaceAll("resources", "");
		String thumbnailSavePath = resourcesPath + "/resources/images/volunteerepilogue/thumbnailImages";	
			
		/*file.transferTo(new File(savePath + "\\" + 
				file.getOriginalFilename()));*/
		
		//파일명을 'yyyyMMddhhmmss.확장자' 로 변경함
		//변경된 파일명이 폴더에 저장되게 함
		String originalFileName = thumbnailFile.getOriginalFilename();
		String renameFileName = null;
		
		if(originalFileName != null){
			File thumbnailDirectory = new File(thumbnailSavePath);
	        //해당 경로의 폴더가 없으면
	        if(!thumbnailDirectory.exists()){
	            //폴더 생성 메서드
	        	thumbnailDirectory.mkdirs();
	        }
	        
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "_" + ((int)(Math.random()*100000)+1) + "." + originalFileName.substring(
							 originalFileName.lastIndexOf(".") + 1);
			//System.out.println("rename : " + renameFileName);
		
			//전송받은 파일 객체를 지정 폴더에 저장함
			thumbnailFile.transferTo(new File(thumbnailSavePath + "//" + thumbnailFile.getOriginalFilename()));				
			
			//파일명 바꾸려면 File 객체의 renameTo() 사용함
			File originFile = new File(thumbnailSavePath + "//" + originalFileName);
			File renameFile = new File(thumbnailSavePath + "//" + renameFileName);
			
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
			volunteerEpilogue.setThumbnail(request.getContextPath() + "/resources/images/volunteerepilogue/thumbnailImages/" + renameFileName);
		}
		/////////////////////////////////////////////////////////////////////////
		
		//뷰에서 가져온  src 의 임시경로를 실제 경로로 변환 작업
		if ( imgList.size() > 0){
			File fileDirectory = new File(resourcesPath + "/resources/images/volunteerepilogue/realUploadImages");
	        //해당 경로의 폴더가 없으면
	        if(!fileDirectory.exists()){
	            //폴더 생성 메서드
	        	fileDirectory.mkdirs();
	        }
					
			for(int i = 0; i < imgList.size(); i ++) {
				//파일명 바꾸려면 File 객체의 renameTo() 사용함
				File cachFile = new File(resourcesPath + imgList.get(i));
				String realFileSrc = imgList.get(i).replaceAll("volunteerapply/cachUploadImages", "volunteerepilogue/realUploadImages");
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
		
		//변환한 태그내용을 저장			
		volunteerEpilogue.setContent_tag(contentTag.replaceAll(System.getProperty("line.separator"), ""));//줄바꿈 공백 지우기
		
		//volunteerEpilogue.setVolunteer_area(volunteerEpilogue.getVolunteer_area().replaceAll("[\"]", "")); //html 태그 값에 넣을때 "가 있으면 값의 끝을 의미하기 때문에 넣을때 " 지우고
		//volunteerEpilogue.setTitle( volunteerEpilogue.getTitle());
		 
		if(volunteerEpilogueService.insertVolunteerEpilogue(volunteerEpilogue) > 0){
			resultMessage = "success";
		}
	
		mav.addObject("resultMessage", resultMessage);		
	
		return mav;
	}
	
	//자원봉사 후기 글 수정하기 페이지 이동
	@RequestMapping(value="VolunteerEpilogueModify", method=RequestMethod.GET)
	public ModelAndView volunteerEpilogueModify(ModelAndView mav, @RequestParam(value="no") int no){
		
		mav.addObject("pageSubType", "VolunteerEpilogueList");
		
		VolunteerEpilogueDto volunteerEpilogue = volunteerEpilogueService.selectVolunteerEpilogue(no);
		
		if(volunteerEpilogue == null){
			
		}
		
		//volunteerEpilogue.setContent_tag(volunteerEpilogue.getContent_tag().replaceAll("'", "\\\\'")); //서머노트 코드는 html에 바로 값을 넣는게 아니라 자바스크립트안에서 함수를 통해 넣는것이기 때문에 자바문자열 표시인 ''를 신경써야한다
		
		mav.addObject("volunteerEpilogue", volunteerEpilogue);
		
		mav.setViewName("client/volunteerepilogue/volunteerEpilogueModify");
		
		return mav;
	}
	
	@RequestMapping(value="updateVolunteerEpilogue", method=RequestMethod.POST)
	public ModelAndView updateVolunteerEpilogue(ModelAndView mav, HttpServletRequest request, VolunteerEpilogueDto volunteerEpilogue,
	@RequestParam(value="imgList",required=false)ArrayList<String> imgList, @RequestParam(name="thumbnailfile",required=false) MultipartFile thumbnailFile)
	throws Exception{
	
		mav.setViewName("jsonView");
		String resultMessage = "fail";

		int insertImgCount = volunteerEpilogue.getInsertImgCount();
		//세션에서 현재 아이디 값 가져오기
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}

		volunteerEpilogue.setId(loginDto.getId()); 
		
		//뷰에서 가져온  src 의 임시경로를 실제 경로로 변환 작업
		String resourcesPath = request.getSession().getServletContext().getRealPath("resources");
		resourcesPath = resourcesPath.replaceAll("resources", "");
		String contentTag = volunteerEpilogue.getContent_tag();
		
		
		
		///////////////썸네일 추출 영역///////////////////////////////////////////
		//가져온 이미지 파일이 있으면(이전 썸네일 변경이 있었다면)
		if(thumbnailFile != null && thumbnailFile.getOriginalFilename() != ""){
			String thumbnailSavePath = resourcesPath + "/resources/images/volunteerepilogue/thumbnailImages";
			String originalFileName = thumbnailFile.getOriginalFilename();
			String renameFileName = null;
			
			if(originalFileName != null){
				File thumbnailDirectory = new File(thumbnailSavePath);
		        //해당 경로의 폴더가 없으면
		        if(!thumbnailDirectory.exists()){
		            //폴더 생성 메서드
		        	thumbnailDirectory.mkdirs();
		        }
		        
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "_" + ((int)(Math.random()*100000)+1) + "." + originalFileName.substring(
								 originalFileName.lastIndexOf(".") + 1);
				//System.out.println("rename : " + renameFileName);
			
				//전송받은 파일 객체를 지정 폴더에 저장함
				thumbnailFile.transferTo(new File(thumbnailSavePath + "//" + thumbnailFile.getOriginalFilename()));				
				
				//파일명 바꾸려면 File 객체의 renameTo() 사용함
				File originFile = new File(thumbnailSavePath + "//" + originalFileName);
				File renameFile = new File(thumbnailSavePath + "//" + renameFileName);
				
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
		
				File removePrevThumbnail = new File(resourcesPath + volunteerEpilogue.getThumbnail());
				if(removePrevThumbnail.exists()){
					removePrevThumbnail.delete();//이전 썸네일 삭제
				}
				volunteerEpilogue.setThumbnail("/resources/images/volunteerepilogue/thumbnailImages/" + renameFileName);//새로운 썸네일 담기
			}
		}
		////////////////////////썸네일 추출 영역 끝//////////////////////////////////////////////////
		
		if (insertImgCount > 0){		
			File fileDirectory = new File(resourcesPath + "/resources/images/volunteerepilogue/realUploadImages");
	        //해당 경로의 폴더가 없으면
	        if(!fileDirectory.exists()){
	            //폴더 생성 메서드
	        	fileDirectory.mkdirs();
	        }
					
			for(int i = 0; i < insertImgCount; i ++) {
				//파일명 바꾸려면 File 객체의 renameTo() 사용함
				File cachFile = new File(resourcesPath + imgList.get(i));
				String realFileSrc = imgList.get(i).replaceAll("volunteerapply/cachUploadImages", "volunteerepilogue/realUploadImages");
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
		
		//수정전 이미지가 없었거나 지운 이미지가 있으면
		if(insertImgCount < imgList.size()){ //imglist 사이즈가 더 커야 뒤에 지워야 할 데이터가 있으니
			for(int i=insertImgCount; i< imgList.size(); i++){
				File removeFile = new File(resourcesPath + imgList.get(i));
				if(removeFile.exists()){
					removeFile.delete();
				}
			}
		}
		
		//변환한 태그내용을 저장			
		volunteerEpilogue.setContent_tag(contentTag.replaceAll(System.getProperty("line.separator"), ""));//줄바꿈 공백 지우기
		
		if(volunteerEpilogueService.updateVolunteerEpilogue(volunteerEpilogue) > 0){
			resultMessage = "success";
		}
		
		mav.addObject("resultMessage", resultMessage);
	
		return mav;
	}
	
	//해당 자원봉사 후기 글 안 보이게 하기(상태 바꾸기)
	@RequestMapping(value="updateNonActiveVolunteerEpilogue", method=RequestMethod.POST)
	public ModelAndView updateNonActiveVolunteerEpilogue(ModelAndView mav, VolunteerEpilogueDto volunteerEpilogue, HttpServletRequest request){
		
		mav.setViewName("jsonView");
		String resultMessage = "fail";
			
		if(volunteerEpilogueService.updateNonActiveVolunteerEpilogue(volunteerEpilogue) > 0 ){
			resultMessage = "success";
		}
		
		mav.addObject("resultMessage", resultMessage);
				
		return mav;
	}
	
	//자원봉사 후기글 댓글 목록 불러오기
	@RequestMapping(value="selectVolunteerEpilogueReplyList", method=RequestMethod.POST)
	public ModelAndView selectVolunteerEpilogueReplyList(ModelAndView mav, @RequestParam("no")String no, VolunteerEpilogueReplyDto keywordDto){
		//자원봉사 후기 댓글 갯수 가져오는것도 이안에서 처리	
		mav.setViewName("jsonView");
		
		int countList = 10;//한페이지에 보일 게시글 갯수
		keywordDto.setCount_list(10);
		keywordDto.setNo(Integer.parseInt(no));
		//자원봉사 후기 검색 결과 목록 글 갯수 가져오기
		int boardCount = volunteerEpilogueService.selectCountVolunteerEpilogueReplyList(keywordDto);
			
		int countPage = 10;	//한페이지에 보일 페이지네이션 총 페이지 수			
		int maxPage = boardCount / countList;
		int currentPage = keywordDto.getCurrent_page();
		
		if(boardCount % countList > 0){
			maxPage++;
		}
			
		if(maxPage < currentPage){
			currentPage = maxPage;
		}
		
	
		int start_row = (currentPage - 1)  * countList +1;
		int end_row = start_row + countList - 1;
		
		keywordDto.setStart_row(start_row);
		keywordDto.setEnd_row(end_row);
	
		ArrayList<VolunteerEpilogueReplyDto> list = volunteerEpilogueService.selectVolunteerEpilogueReplyList(keywordDto);
		//보드 리플 리스트들
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
		pageMap.put("board_count", boardCount);
		//페이지, 키워드에 대한 정보들
		mav.addObject("infoMap", pageMap);
		
		return mav;
	}
	
	//자원봉사 댓글 등록하기
	@RequestMapping(value="insertVolunteerEpilogueReply", method=RequestMethod.POST)
	public ModelAndView insertVolunteerEpilogueReply(ModelAndView mav, VolunteerEpilogueReplyDto volunteerEpilogueReply, HttpServletRequest request){
		mav.setViewName("jsonView");
		String resultMessage = "fail";
		
		//세션에서 현재 아이디 값 가져오기
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}
	
		volunteerEpilogueReply.setId(loginDto.getId());
		
		if(volunteerEpilogueService.insertVolunteerEpilogueReply(volunteerEpilogueReply) > 0 ){
			resultMessage = "success";
		}
		
		mav.addObject("resultMessage", resultMessage);
		
		return mav;
	}
	
	//자원봉사 후기글 댓글 수정하기
	@RequestMapping(value="updateVolunteerEpilogueReply", method=RequestMethod.POST)
	public ModelAndView updateVolunteerEpilogueReply(ModelAndView mav, VolunteerEpilogueReplyDto volunteerEpilogueReply, HttpServletRequest request){
		
		mav.setViewName("jsonView");
		mav.addObject("resultMessage", "fail"); //실패가 초기값
		
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}
		
		volunteerEpilogueReply.setId(loginDto.getId());
		
		if(volunteerEpilogueService.updateVolunteerEpilogueReply(volunteerEpilogueReply) > 0){
			mav.addObject("resultMessage", "success");
		}
		
	
		return mav;
	}
	
	//자원봉사 후기글 댓글 삭제하기
	@RequestMapping(value="deleteVolunteerEpilogueReply", method=RequestMethod.POST)
	public ModelAndView deleteVolunteerEpilogueReply(ModelAndView mav, VolunteerEpilogueReplyDto volunteerEpilogueReply, HttpServletRequest request){
		
		mav.setViewName("jsonView");
		mav.addObject("resultMessage", "fail"); //실패가 초기값
		
		//예외처리 부분
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){		
			//예외처리
			return mav;
		}
		
		volunteerEpilogueReply.setId(loginDto.getId());
		
		if(volunteerEpilogueService.deleteVolunteerEpilogueReply(volunteerEpilogueReply) > 0){
			mav.addObject("resultMessage", "success");
		}
		
		return mav;
	}
}
