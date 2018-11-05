package com.kh.viewnimal.freeboard.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.DatatypeConverter;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.freeboard.model.dto.FreeBoardDto;
import com.kh.viewnimal.freeboard.model.dto.FreeBoardReplyDto;
import com.kh.viewnimal.freeboard.model.service.FreeBoardService;
import com.kh.viewnimal.member.model.dto.MemberDto;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplyDto;

@Controller
public class FreeBoardController {
	
	@Autowired
	private FreeBoardService freeBoardService;
	
	//자유게시판 리스트
	@RequestMapping( "FreeBoardList" )
	public ModelAndView selectListFreeBoard(
		Integer currentPage, ModelAndView mav
	){
		
		//페이징처리
		int totalCount	= freeBoardService.selectTotalCountFreeBoard();
		
		HashMap<String, Integer> row = new HashMap<>();
		
		if( null == currentPage )
		{
			currentPage = 1;
		}
		
		int printCount	= 10;
		int printPage	= 5;
		int totalPage	= totalCount / printCount;
		
		if( totalCount % printCount > 0 )
		{
			totalPage ++;
		}
		
		int startPage	= ( (currentPage - 1) / printPage ) * printPage + 1;
		int endPage		= startPage + printPage - 1;
		
		if( endPage > totalPage )
		{
			endPage	= totalPage;
		}

		int startRow	= ( currentPage - 1 ) * printCount + 1;
		int endRow		= currentPage * printCount;
		
		row.put( "startRow", startRow );
		row.put( "endRow", endRow );

		//리스트 불러오기
		ArrayList<FreeBoardDto> list = freeBoardService.selectListFreeBoard( row );
		
		mav.addObject( "currentPage", currentPage );
		mav.addObject( "printPage", printPage );
		mav.addObject( "totalPage", totalPage );
		mav.addObject( "startPage", startPage );
		mav.addObject( "endPage", endPage );
		mav.addObject( "list", list );
		mav.addObject( "pageSubType", "FreeBoardList" );
		mav.setViewName( "client/freeBoard/freeBoardList" );

		return mav;

	}
	
	//자유게시판 상세페이지
	@RequestMapping( "FreeBoardDetail" )
	public ModelAndView selectDetailFreeBoard(
		@RequestParam(value="no") int no, ModelAndView mav
	) throws UnsupportedEncodingException{
		
		//조회수
		freeBoardService.updateReadCount( no );
		
		FreeBoardDto result = freeBoardService.selectDetailFreeBoard( no );
		
		mav.addObject( "freeBoardDto", result );
		mav.addObject( "pageSubType", "FreeBoardList" );
		mav.setViewName( "client/freeBoard/freeBoardDetail" );
		
		return mav;
	}
	
	//자유게시판 글 작성 페이지 이동 ( 원글, 답글 , 수정 )
	@RequestMapping( value="FreeBoardWrite", method=RequestMethod.POST )
	public ModelAndView moveFreeBoard(
		String type, FreeBoardDto freeBoardDto, ModelAndView mav
	){
		
		if ( !type.equals("first") )
		{
			mav.addObject( "freeBoardDto", freeBoardDto );
		} 
		
		mav.addObject( "type", type );
		mav.addObject( "pageSubType", "FreeBoardList" );
		mav.setViewName( "client/freeBoard/freeBoardWrite" );
		
		return mav;
	}
	
	//섬머노트 이미지 파일 즉시 업로드
	@RequestMapping(value="freeBoardFileUpload", method=RequestMethod.POST)
	public ModelAndView testFileUpload(HttpServletRequest request, ModelAndView mav, @RequestParam(name="file") MultipartFile file) throws Exception{
		/*System.out.println("sample : " + sample);
		System.out.println("file : " + file.getOriginalFilename());*/
		
		//파일 저장 폴더 지정하기(임시 저장소 경로)
		String savePath = request.getSession().getServletContext().getRealPath("resources/images/freeBoard/cachUploadImages");	
			
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
			File originFile = new File(savePath + "//" + originalFileName);
			File renameFile = new File(savePath + "//" + renameFileName);
			
			//파일 이름바꾸기 실행 >> 실패할 경우 직접 바꾸기함
			//새 파일만들고 원래 파일 내용 읽어서 복사하고
			//복사가 끝나면 원래 파일 삭제함
			if(!originFile.renameTo(renameFile)){
				int read = -1;
				byte[] buf = new byte[1024];
				
				FileInputStream fin = new FileInputStream(originFile);
				FileOutputStream fout = new FileOutputStream(renameFile);
				
				while((read = fin.read(buf, 0, buf.length)) != -1){
					fout.write(buf, 0, read);
				}
				
				fin.close();
				fout.close();	
				originFile.delete();
			}
			
			String imgUrl = request.getContextPath() + "/resources/images/freeBoard/cachUploadImages/" + renameFileName;
			mav.addObject("imgUrl", imgUrl);
		}
		
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	//자유게시판 원글 등록
	@RequestMapping(value="InsertFreeBoard", method=RequestMethod.POST)
	public ModelAndView insertVolunteerApply(
		HttpServletRequest request, ModelAndView mav, FreeBoardDto freeBoardDto, @RequestParam(value="imgListArr", required=false) String imgListArr
	) throws Exception{

		JSONParser jsonParser = new JSONParser();
		ArrayList<String> imgList = (ArrayList<String>)jsonParser.parse(imgListArr);
		String resultMessage = "fail";
		
		//세션에서 현재 아이디 값 가져오기
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("loginMemberDto");
		freeBoardDto.setId(memberDto.getId()); 
		
		//뷰에서 가져온  src 의 임시경로를 실제 경로로 변환 작업
		if ( imgList.size() > 0){
			String resourcesPath = request.getSession().getServletContext().getRealPath("resources");
			resourcesPath = resourcesPath.replaceAll("resources", "");
			File fileDirectory = new File(resourcesPath + "/resources/images/freeBoard/realUploadImages");
	        //해당 경로의 폴더가 없으면
	        if(!fileDirectory.exists()){
	            //폴더 생성 메서드
	        	fileDirectory.mkdirs();
	        }
			
			String contentTag = freeBoardDto.getContent_tag();
					
			for(int i = 0; i < imgList.size(); i ++) {
				//파일명 바꾸려면 File 객체의 renameTo() 사용함t
				File cachFile = new File(resourcesPath + imgList.get(i));
				String realFileSrc = imgList.get(i).replaceAll("cachUploadImages", "realUploadImages");
				File realFile = new File(resourcesPath + realFileSrc);
				//File realFile = new File(path + "/" + realFileSrc);
				

				//파일 이름바꾸기 실행 >> 실패할 경우 직접 바꾸기함
				//새 파일만들고 원래 파일 내용 읽어서 복사하고
				//복사가 끝나면 원래 파일 삭제함
				if(!cachFile.renameTo(realFile)){
					int read = -1;
					byte[] buf = new byte[1024];
					
					FileInputStream fin = new FileInputStream(cachFile);
					FileOutputStream fout = new FileOutputStream(realFile);
					
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
			//변환한 태그내용을 저장			
			freeBoardDto.setContent_tag(contentTag);
			
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
		 
		if(freeBoardService.insertFreeBoard( freeBoardDto ) > 0){
			resultMessage = "success";
		}
		
		mav.addObject("resultMessage", resultMessage);
		mav.setViewName("jsonView");
	
		return mav;
	}
		
	
	//자유게시판 답글 작성 insert
	@RequestMapping(value="InsertWriteReplyFreeBoard", method=RequestMethod.POST)
	public ModelAndView insertWriteReplyFreeBoard(
		HttpServletRequest request, ModelAndView mav, FreeBoardDto freeBoardDto, @RequestParam(value="imgListArr", required=false) String imgListArr
	) throws ParseException, IOException{
		
		JSONParser jsonParser = new JSONParser();
		ArrayList<String> imgList = (ArrayList<String>)jsonParser.parse(imgListArr);
		String resultMessage = "fail";
		
		//세션에서 현재 아이디 값 가져오기
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("loginMemberDto");
		freeBoardDto.setId(memberDto.getId()); 
		
		//뷰에서 가져온  src 의 임시경로를 실제 경로로 변환 작업
		if ( imgList.size() > 0){
			String resourcesPath = request.getSession().getServletContext().getRealPath("resources");
			resourcesPath = resourcesPath.replaceAll("resources", "");
			File fileDirectory = new File(resourcesPath + "/resources/images/freeBoard/realUploadImages");
	        //해당 경로의 폴더가 없으면
	        if(!fileDirectory.exists()){
	            //폴더 생성 메서드
	        	fileDirectory.mkdirs();
	        }
			
			String contentTag = freeBoardDto.getContent_tag();
					
			for(int i = 0; i < imgList.size(); i ++) {
				//파일명 바꾸려면 File 객체의 renameTo() 사용함t
				File cachFile = new File(resourcesPath + imgList.get(i));
				String realFileSrc = imgList.get(i).replaceAll("cachUploadImages", "realUploadImages");
				File realFile = new File(resourcesPath + realFileSrc);
				//File realFile = new File(path + "/" + realFileSrc);
				

				//파일 이름바꾸기 실행 >> 실패할 경우 직접 바꾸기함
				//새 파일만들고 원래 파일 내용 읽어서 복사하고
				//복사가 끝나면 원래 파일 삭제함
				if(!cachFile.renameTo(realFile)){
					int read = -1;
					byte[] buf = new byte[1024];
					
					FileInputStream fin = new FileInputStream(cachFile);
					FileOutputStream fout = new FileOutputStream(realFile);
					
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
			//변환한 태그내용을 저장			
			freeBoardDto.setContent_tag(contentTag);
			
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
		 
		freeBoardService.updateBeforeInsertFreeBoard( freeBoardDto );
		
		if( freeBoardService.insertWriteReplyFreeBoard( freeBoardDto ) > 0){
			resultMessage = "success";
		}
		
		mav.addObject("resultMessage", resultMessage);
		
		mav.setViewName("jsonView");
	
		return mav;

	}
	
	//자유게시판 글 수정
	@RequestMapping(value="updateFreeBaord", method=RequestMethod.POST)
	public ModelAndView updateFreeBaord(
	HttpServletRequest request, ModelAndView mav, FreeBoardDto freeBoardDto, @RequestParam(value="imgListArr", required=false) String imgListArr
	) throws Exception{
		
		JSONParser jsonParser = new JSONParser();
		ArrayList<String> imgList = (ArrayList<String>)jsonParser.parse(imgListArr);
		String resultMessage = "fail";
		
		//세션에서 현재 아이디 값 가져오기
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("loginMemberDto");
		freeBoardDto.setId(memberDto.getId()); 
		
		//뷰에서 가져온  src 의 임시경로를 실제 경로로 변환 작업
		if ( imgList.size() > 0){
			String resourcesPath = request.getSession().getServletContext().getRealPath("resources");
			resourcesPath = resourcesPath.replaceAll("resources", "");
			File fileDirectory = new File(resourcesPath + "/resources/images/freeBoard/realUploadImages");
	        //해당 경로의 폴더가 없으면
	        if(!fileDirectory.exists()){
	            //폴더 생성 메서드
	        	fileDirectory.mkdirs();
	        }
			
			String contentTag = freeBoardDto.getContent_tag();
					
			for(int i = 0; i < imgList.size(); i ++) {
				//파일명 바꾸려면 File 객체의 renameTo() 사용함t
				File cachFile = new File(resourcesPath + imgList.get(i));
				String realFileSrc = imgList.get(i).replaceAll("cachUploadImages", "realUploadImages");
				File realFile = new File(resourcesPath + realFileSrc);
				//File realFile = new File(path + "/" + realFileSrc);
				

				//파일 이름바꾸기 실행 >> 실패할 경우 직접 바꾸기함
				//새 파일만들고 원래 파일 내용 읽어서 복사하고
				//복사가 끝나면 원래 파일 삭제함
				if(!cachFile.renameTo(realFile)){
					int read = -1;
					byte[] buf = new byte[1024];
					
					FileInputStream fin = new FileInputStream(cachFile);
					FileOutputStream fout = new FileOutputStream(realFile);
					
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
			//변환한 태그내용을 저장			
			freeBoardDto.setContent_tag(contentTag);
			
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
		 
		if(freeBoardService.updateFreeBoard( freeBoardDto ) > 0){
			resultMessage = "success";
		}
		
		mav.addObject("resultMessage", resultMessage);
		mav.addObject( "pageSubType", "FreeBoardList" );
		mav.setViewName("jsonView");
	
		return mav;

	}
	
	@RequestMapping( value="updateNonActiveFreeBoard", method=RequestMethod.POST )
	//자유게시판 글 삭제 (비공개)
	public ModelAndView updateNonActiveFreeBoard(
		@RequestParam(value="no") int no, ModelAndView mav
	){
		
		int result = freeBoardService.updateNonActiveFreeBoard( no );
		System.out.println( "result : " + result );
		
		mav.addObject( "result", result );
		mav.addObject( "pageSubType", "FreeBoardList" );
		mav.setViewName( "jsonView" );
		return mav;
	}

	//자유게시판 글 검색
	public ModelAndView selectSearchListFreeBoard(ModelAndView mv){
		//카테고리 불러오기
		
		return mv;
	}
	
	@RequestMapping( value="SelectListFreeBoardReply", method=RequestMethod.GET )	
	//자유게시판 댓글 리스트
	public ModelAndView selectListfreeBoardReply(
		Integer currentPage, HttpServletRequest request, ModelAndView mav 
	) throws UnsupportedEncodingException{
		
		int board_no = Integer.parseInt( request.getParameter("board_no") );
		HashMap<String, Integer> row = new HashMap<>();
		
		//페이징처리
		int totalCount	= freeBoardService.selectTotalCountFreeBoardReply( board_no );
		
		if( null == currentPage )
		{
			currentPage = 1;
		}
		
		int printCount	= 10;
		int printPage	= 10;
		int totalPage	= totalCount / printCount;
		
		if( totalCount % printCount > 0 )
		{
			totalPage ++;
		}
		
		int startPage	= ( (currentPage - 1) / printPage ) * printPage + 1;
		int endPage		= startPage + printPage - 1;
		
		if( endPage > totalPage )
		{
			endPage	= totalPage;
		}
		
		int startRow	= ( currentPage - 1 ) * printCount + 1;
		int endRow		= currentPage * printCount;
		
		row.put( "startRow", startRow );
		row.put( "endRow", endRow );
		row.put( "board_no", board_no );
		
		
		//댓글 리스트
		ArrayList<FreeBoardReplyDto> list = freeBoardService.selectListFreeBoardReply( row );
		
		JSONObject json	= new JSONObject();
		JSONArray jarr	= new JSONArray();

		for(FreeBoardReplyDto e : list)
		{
			JSONObject job = new JSONObject();
			job.put( "id", e.getId() );
			job.put( "no", e.getNo() );
			job.put( "write_date", String.valueOf(e.getWrite_date()) );
			job.put( "reply_content", URLEncoder.encode(e.getReply_content(), "UTF-8") );
			job.put( "group_no", e.getGroup_no() );
			job.put( "parent_no", e.getParent_no() );
			job.put( "reply_level", e.getReply_level() );
			job.put( "nickname", URLEncoder.encode(e.getNickname(), "UTF-8") );
	
			jarr.add(job);
		}
		
		mav.addObject( "currentPage", currentPage );
		mav.addObject( "printPage", printPage );
		mav.addObject( "totalPage", totalPage );
		mav.addObject( "startPage", startPage );
		mav.addObject( "endPage", endPage );
		mav.addObject( "totalCount", totalCount );
		mav.addObject( "list", jarr );
		mav.setViewName( "jsonView" );
		return mav;
	}
	
	//자유게시판 댓글 작성
	@RequestMapping( value="InsertFreeBoardReply", method=RequestMethod.POST )
	public ModelAndView insertFreeBoardReply(
		FreeBoardReplyDto freeBoardReplyDto, ModelAndView mav
	){
		
		int result = freeBoardService.insertFreeBoardReply( freeBoardReplyDto );
		
		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );
		return mav;
	}
	
	//자유게시판 댓글 수정
	@RequestMapping( value="UpdateFreeBoardReply", method=RequestMethod.GET )
	public ModelAndView updateFreeBoardReply(
		FreeBoardReplyDto freeBoardReplyDto, HttpServletRequest request, ModelAndView mav
	){
		int result = freeBoardService.updateFreeBoardReply( freeBoardReplyDto );
		
		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );
		return mav;
	}
	
	//자유게시판 댓글 삭제
	@RequestMapping( value="DeleteFreeBoardReply", method=RequestMethod.GET )
	public ModelAndView deleteFreeBoardReply(
		HttpServletRequest request, ModelAndView mav
	){
		
		int no = Integer.parseInt( request.getParameter("no") );
		int result = freeBoardService.deleteFreeBoardReply( no );
		
		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );
		return mav;
	}
	
	
	/*	//자유게시판 원글 작성 insert
	@RequestMapping( "InsertFreeBoard" )
	public ModelAndView insertFreeBoard(
		@RequestBody String param, @RequestParam(value="imgListArr[]", required=false) ArrayList<String> imgList, FreeBoardDto freeBoardDto, HttpServletRequest request, ModelAndView mav
	) throws ParseException{
		
		//freeBoardDto 커맨드 객체로 받고, arr부분만 JSONArray 처리
	
		JSONParser jsonParser	= new JSONParser();
		JSONObject jsonObj		= (JSONObject) jsonParser.parse( param );
		JSONArray imgList		= (JSONArray) jsonParser.parse( jsonObj.get("imgListArr").toString());
		
		for(Object o : imgList){
			String str = (String) o;
			System.out.println( str );
			System.out.println( str.getClass().getName() );
		}
		
		

		if ( null != imgList )
		{
		

			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			for(int i = 0; i < imgList.size(); i++)
			System.out.println(imgList.get(i));
			
			//이미지가 한 장일 경우, bsae64코드 안의 ','를 배열로 인식해 array size가 2 가됨.
			//다시 하나로 합치는 코드.
			if ( false == imgList.get(1).contains("base64") )
			{
				imgList.add(0, imgList.get(0) + "," + imgList.get(1));
				imgList.remove(1);
				imgList.remove(1);
			}
			
			String[] data		= new String[imgList.size()];
			byte[][] imgBytes	= new byte[data.length][];
			String contentTag	= freeBoardDto.getContent_tag();
			String imgPath		= request.getSession().getServletContext().getRealPath("resources/images/freeBoard");
			String fileReName 	= null;
			
			for( int i = 0; i < imgList.size(); i++ )
			{
				
				data[i] = imgList.get(i).split(",")[1];
				imgBytes[i] = DatatypeConverter.parseBase64Binary(data[i]);
			}
			
			try 
			{
				for ( int i = 0; i < imgBytes.length; i ++ ) 
				{
					//파일 새 이름 지정
					SimpleDateFormat sdf	= new SimpleDateFormat("yyyyMMddHHmmss");
					fileReName				= sdf.format(new java.sql.Date(System.currentTimeMillis())) + "-" + i ;
					
					//이미지 파일 생성 후 지정 폴더에 저장
					File file				= new File(imgPath + "//" + fileReName +".png");
					BufferedImage bufImg	= ImageIO.read(new ByteArrayInputStream(imgBytes[i]));
					ImageIO.write(bufImg, "png", file);
					
					//contentTag안의 Base64 코드를 이미지 폴더 경로로 변환
					contentTag = contentTag.replaceAll(imgList.get(i).replaceAll("[+]", "[+]"), "resources/images/freeBoard/" + file.getName());
				}
				
				freeBoardDto.setContent_tag( contentTag );
			}
			catch ( IOException e ) { e.printStackTrace(); }
		}

				
		//int result = freeBoardService.insertFreeBoard( freeBoardDto );
		
		//mav.addObject( "result", result );
		mav.addObject( "pageSubType", "FreeBoardList" );
		mav.setViewName( "jsonView" );
		return mav;
	}*/
	
}
