package com.kh.viewnimal.adoption.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.adoption.model.dto.AdoptionReviewDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionReviewReplyDto;
import com.kh.viewnimal.adoption.model.service.AdoptionApplyService;
import com.kh.viewnimal.adoption.model.service.AdoptionPetService;
import com.kh.viewnimal.adoption.model.service.AdoptionReviewService;

@Controller
public class AdoptionReviewController {
	@Autowired
	private AdoptionReviewService adoptionReviewService;	
	@Autowired
	private AdoptionPetService adoptionPetService;
	@Autowired
	private AdoptionApplyService adoptionApplyService;
	
	// 입양 후기 페이지로 이동
	@RequestMapping("AdoptionReview")
	public ModelAndView moveAdoptionReview(ModelAndView mv, HashMap<String, Integer> hmap){
		
		int currentPage = 1;
		int limit = 4;		
		int listCount = adoptionReviewService.getReviewListCount();	
		int totalPage = (int) ((double) listCount / limit + 0.95);		
		int startPage = (((int) ((double) currentPage / 5 + 0.9)) -1) * 5 + 1;
		int endPage = startPage + 4;
		if(endPage > totalPage)
			endPage = totalPage;
		boolean next = true;
		
		hmap.put("currentPage", currentPage);
		hmap.put("limit", limit);
		
		mv.addObject("pageSubType", "AdoptionReview");
		mv.addObject("reviewList", adoptionReviewService.selectReviewList(hmap));
		mv.addObject("currentPage", currentPage);
		mv.addObject("limit", limit);
		mv.addObject("listCount", listCount);
		mv.addObject("totalPage", totalPage);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("next", next);
		
		mv.setViewName("client/adoption/adoptionReviewList");
		
		return mv;
	}
	
	// 입양 후기 페이징
	@RequestMapping("AdoptionReviewPage")
	public ModelAndView pagingAdoptionReview(ModelAndView mv, HashMap<String, Integer> hmap,
			@RequestParam(name="currentPage") int currentPage, 
			@RequestParam(name="limit") int limit){
	
		int listCount = adoptionReviewService.getReviewListCount(); //전체 게시물 갯수
		
		int totalPage = listCount / limit; //전페 페이지 수
		if((listCount % limit) > 0)
			totalPage ++;
		
		int currentBlock = currentPage / 5; //현재 페이지 블록
		if((currentPage % 5) > 0)
			currentBlock ++;
		
		int lastBlock = listCount / (5 * limit); //마지막 페이지 블록
		if((listCount % (5 * limit)) > 0)
			lastBlock ++;
		
		int startPage = (currentBlock * 5) - 4; //현재 블록의 시작 페이지
		
		int endPage = startPage + 4; //현재 블록의 끝 페이지
		if(currentBlock == lastBlock)
			endPage = totalPage;
		
		boolean prev = false; //이전 페이지
		boolean next; //다음 페이지
		if(currentPage >=1 && currentPage <=5){
			prev = false;
			next = true;
		}else if(lastBlock == currentBlock){
			prev = true;
			next = false;
		}else{
			prev = true;
			next = true;
		}
		
		hmap.put("currentPage", currentPage);
		hmap.put("limit", limit);
		
		mv.addObject("pageSubType", "AdoptionReview");
		mv.addObject("reviewList", adoptionReviewService.selectReviewList(hmap));
		mv.addObject("listCount", listCount);
		mv.addObject("totalPage", totalPage);
		mv.addObject("currentBlock", currentBlock);
		mv.addObject("lastBlock", lastBlock);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("prev", prev);
		mv.addObject("next", next);
		
		mv.setViewName("client/adoption/adoptionReviewList");
		
		return mv;
	}
	
	// 입양 후기 상세보기
	@RequestMapping("AdoptionReviewDetail")
	public ModelAndView AdoptionReviewDetail(ModelAndView mv,
			@RequestParam(name="pet_id") String pet_id, @RequestParam(name="no") int origin_no){
	
		adoptionReviewService.updateCount(origin_no); //조회수 증가
		
		System.out.println(pet_id + "꺼 리뷰보기");	
		mv.addObject("pageSubType", "AdoptionReview");
		mv.addObject("pet", adoptionPetService.selectPet(pet_id));
		mv.addObject("petReview", adoptionReviewService.selectAdoptionReviewDetail(pet_id));
		mv.addObject("replyCount", adoptionReviewService.getReplyCount(origin_no));
		
		mv.setViewName("client/adoption/adoptionReviewDetail");
		
		return mv;
	}	
	
	// 입양 후기 등록 페이지로 이동
	@RequestMapping("MoveReviewWrite")
	public ModelAndView moveReviewWritePage(ModelAndView mv,
			@RequestParam(name="name") String name,
			@RequestParam(name="no") int no){
		
		System.out.println(name+","+no);
		mv.addObject("pageSubType", "AdoptionReview");
		mv.addObject("review", adoptionReviewService.selectPet(name));
		mv.addObject("apply", adoptionApplyService.selectApplyAdoption(no));
		
		mv.setViewName("client/adoption/adoptionReviewWrite");
		
		return mv;
	}
	
	// 입양 후기 등록
	@RequestMapping("ReviewEnroll")
	public ModelAndView insertReview(ModelAndView mv, AdoptionReviewDto review, HttpServletRequest request,
			@RequestParam(name="imageFile", required=false) MultipartFile file,
			@RequestParam(name="pet_id") String pet_id,
			@RequestParam(name="no", required=false) int no){
		
		System.out.println(pet_id+","+no);
		//경로 지정
		String path = request.getSession().getServletContext().getRealPath("resources/images/adoption");
		
		try {
			String oFileName = file.getOriginalFilename();
			String rFileName = null;
			
			if(oFileName != null){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			
				rFileName = "R" + sdf.format(new java.sql.Date(System.currentTimeMillis()))
						+ "." + oFileName.substring(oFileName.lastIndexOf(".") + 1);
			
			file.transferTo(new File(path + "/" + file.getOriginalFilename()));
			
			File originFile = new File(path + "/" + oFileName);
			File renameFile = new File(path + "/" + rFileName);
			
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
			}
			review.setImage(rFileName);
			review.setPet_id(pet_id);
			
			adoptionPetService.updateActive(pet_id); //active 상태 'N'으로
			adoptionApplyService.updateReview(no); //review 상태 'Y'으로
			adoptionReviewService.insertReview(review);
						
			mv.setViewName("redirect:AdoptionReview");
			
		} catch (Exception e) {
			e.printStackTrace();			
		}
		
		return mv;
	}

	// 입양 후기 수정 페이지로 이동
	@RequestMapping("MoveReviewUpdate")
	public ModelAndView updateAdoptionReview(ModelAndView mv,
			@RequestParam(name="pet_id") String pet_id){
		
		mv.addObject("pageSubType", "AdoptionReview");
		mv.addObject("pet", adoptionPetService.selectPet(pet_id));
		mv.addObject("petReview", adoptionReviewService.selectAdoptionReviewDetail(pet_id));
		
		mv.setViewName("client/adoption/adoptionReviewUpdate");
		
		return mv;
	}	
	
	// 입양 후기 수정
	@RequestMapping(value="ReviewUpdate", method=RequestMethod.POST)
	public ModelAndView updateApplyPet(ModelAndView mv, AdoptionReviewDto review, HttpServletRequest request,
			@RequestParam(name="imageFile", required=false) MultipartFile file) {
 
		String path = request.getSession().getServletContext().getRealPath("resources/images/adoption");
		
		try {
			
			if(file.getOriginalFilename() != ""){
				
				String oFileName = file.getOriginalFilename();
				String rFileName = null;
			
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			
				rFileName = "R" + sdf.format(new java.sql.Date(System.currentTimeMillis()))
					+ "." + oFileName.substring(oFileName.lastIndexOf(".") + 1);
		
				file.transferTo(new File(path + "/" + file.getOriginalFilename()));
				
				File originFile = new File(path + "/" + oFileName);
				File renameFile = new File(path + "/" + rFileName);
				
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
				
				review.setImage(rFileName);
			}
		
			mv.addObject("pageSubType", "AdoptionReview");	
			mv.addObject("pet", adoptionReviewService.updateAdoptionReview(review));
			mv.addObject("petReview", adoptionReviewService.selectAdoptionReviewDetail(review.getId()));
			
			mv.setViewName("redirect:AdoptionReview");
			
		} catch (Exception e) {
			e.printStackTrace();	
			
		}			
		
		return mv;
	}
	
	// 입양 후기 삭제
	@RequestMapping(value="DeleteReview", method=RequestMethod.POST)
	public ModelAndView deleteReview(ModelAndView mv,
			@RequestParam(name="no") int no){
		
		int result = adoptionReviewService.deleteReview(no);
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	// 입양 후기 댓글 조회
	@RequestMapping(value="ListReply", method=RequestMethod.POST)
	public ModelAndView selectAdoptionReviewReply(ModelAndView mv,
			@RequestParam(name="no") int no){
		
		List<AdoptionReviewReplyDto> list = adoptionReviewService.selectAdoptionReviewReply(no);		
		
		JSONArray jar = new JSONArray();
		
		for(AdoptionReviewReplyDto replyDto : list){
			
			JSONObject job = new JSONObject();
			
			job.put("writer", replyDto.getWriter());
			job.put("write_date", replyDto.getWrite_date());
			job.put("content", replyDto.getContent());
			job.put("no", replyDto.getNo()); //댓글 번호
			
			jar.add(job);
		}
		
		mv.addObject("list", jar);
		mv.addObject("replyCount", adoptionReviewService.getReplyCount(no));
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	// 입양 후기 댓글 입력
	@RequestMapping(value="InsertReply", method=RequestMethod.POST)
	public ModelAndView insertAdoptionReviewReply(ModelAndView mv, HashMap<String, Object> hmap,
			@RequestParam(name="content") String content,
			@RequestParam(name="writer") String writer,
			@RequestParam(name="origin_no") int origin_no){
		
		hmap.put("content", content);
		hmap.put("writer", writer);
		hmap.put("origin_no", origin_no);
		
		int result = adoptionReviewService.insertReply(hmap);
		int count = adoptionReviewService.getReviewListCount();		
		
		mv.addObject("result", result);
		mv.addObject("count", count);
		
		mv.setViewName("jsonView");

		return mv;
	}
	
	// 입양 후기 댓글 수정
	@RequestMapping(value="UpdateReply", method=RequestMethod.POST)
	public ModelAndView updateAdoptionReviewReply(ModelAndView mv, HashMap<String, Object> hmap,
			@RequestParam(name="content") String content,
			@RequestParam(name="no") int no){
		
		System.out.println(no+","+content);
		hmap.put("no", no);
		hmap.put("content", content);
		
		int result = adoptionReviewService.updateReply(hmap);
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		
		return mv;
	}

	// 입양 후기 댓글 삭제
	@RequestMapping("DeleteReply")
	public ModelAndView deleteAdoptionReviewReply(ModelAndView mv,
			@RequestParam(name="no") int no){
		
		int result = adoptionReviewService.deleteReply(no);
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
}
