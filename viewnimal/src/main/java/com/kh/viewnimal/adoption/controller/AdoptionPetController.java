package com.kh.viewnimal.adoption.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;
import com.kh.viewnimal.adoption.model.service.AdoptionPetService;

@Controller
public class AdoptionPetController {
	@Autowired
	private AdoptionPetService adoptionPetService;
	
	// 입양 페이지로 이동
	@RequestMapping("Adoption")
	public ModelAndView moveAdoptionPet(ModelAndView mv, HashMap<String, Integer> hmap){
		
		int currentPage = 1;
		int limit = 6;
		int listCount = adoptionPetService.getPetListCount();
		int totalPage = (int) ((double)listCount / limit + 0.95);
		int startPage = (((int) ((double) currentPage / 5 + 0.9)) -1) * 5 + 1;
		int endPage = startPage + 4;
		if(endPage > totalPage)
			endPage = totalPage;
		boolean next = true;
		
		hmap.put("currentPage", currentPage);
		hmap.put("limit", limit);
		
		mv.addObject("pageSubType", "Adoption");
		mv.addObject("petList", adoptionPetService.selectPetList(hmap));
		mv.addObject("currentPage", currentPage);
		mv.addObject("limit", limit);
		mv.addObject("listCount", listCount);
		mv.addObject("totalPage", totalPage);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("next", next);
		
		mv.setViewName("client/adoption/adoptionPetList");
		
		return mv;
	}
	
	// 입양 동물 페이징
	@RequestMapping("AdoptionPage")
	public ModelAndView pagingAdoptionPet(ModelAndView mv, HashMap<String, Integer> hmap,
			@RequestParam(name="currentPage") int currentPage, 
			@RequestParam(name="limit") int limit){
		
		System.out.println("currentPage : "+currentPage +", limit : ");
		
		int listCount = adoptionPetService.getPetListCount(); //전체 게시물 갯수
		
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
		
		mv.addObject("pageSubType", "Adoption");
		mv.addObject("petList", adoptionPetService.selectPetList(hmap));
		mv.addObject("listCount", listCount);
		mv.addObject("totalPage", totalPage);
		mv.addObject("currentBlock", currentBlock);
		mv.addObject("lastBlock", lastBlock);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("prev", prev);
		mv.addObject("next", next);
		
		mv.setViewName("client/adoption/adoptionPetList");
		
		return mv;
	}	 

	// 입양 동물 등록 페이지로 이동
	@RequestMapping("MoveAdoptionPetEnroll")
	public ModelAndView moveAdoptionEnrollPage(ModelAndView mv) {
		
		mv.addObject("pageSubType", "Adoption");
		mv.setViewName("client/adoption/adoptionPetEnroll");
		
		return mv;
	}

	// 입양 동물 등록
	@RequestMapping(value="PetEnroll", method=RequestMethod.POST)
	public ModelAndView insertPet(ModelAndView mv, AdoptionPetDto pet, HttpServletRequest request,
			@RequestParam(name="imageFile", required=false) MultipartFile file){
		
		//경로 지정
		String path = request.getSession().getServletContext().getRealPath("resources/images/adoption");
		
		try {
			
			String oFileName = file.getOriginalFilename();
			String rFileName = null;
			
			if(oFileName != null){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			
				rFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()))
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
				
			pet.setImage(rFileName);
			adoptionPetService.insertPet(pet);
			
			mv.setViewName("redirect:Adoption");
			
		} catch (Exception e) {
			e.printStackTrace();			
		}	
		
		return mv;
	}
	
	// 입양 동물 수정 페이지로 이동
	@RequestMapping("MoveAdoptionPetUpdate")
	public ModelAndView moveAdoptionPetUpdate(ModelAndView mv,
			@RequestParam(name="id") String pet_id){
		
		mv.addObject("pageSubType", "Adoption");		
		mv.addObject("pet", adoptionPetService.selectPet(pet_id));
		//mv.addObject("petList", adoptionPetService.selectPetList(hmap));
		mv.setViewName("client/adoption/adoptionPetUpdate");
		
		return mv;
	}

	// 입양 동물 수정
	@RequestMapping(value="PetUpdate", method=RequestMethod.POST)
	public ModelAndView updateApplyPet(ModelAndView mv, AdoptionPetDto pet, HttpServletRequest request,
			@RequestParam(name="imageFile", required=false) MultipartFile file) {
		
		String path = request.getSession().getServletContext().getRealPath("resources/images/adoption");
		
		try {
			
			if(file.getOriginalFilename() != ""){
				
				String oFileName = file.getOriginalFilename();
				//String oFileName = pet.getImage();
				String rFileName = null;
			
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			
				rFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()))
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
				
				pet.setImage(rFileName);
			}
			
			System.out.println("수정된 내용은 "+pet);
			
			mv.addObject("pageSubType", "AdoptionReview");
			mv.addObject("pet", adoptionPetService.updatePet(pet));	
			
			mv.setViewName("redirect:Adoption");
			
		} catch (Exception e) {
			e.printStackTrace();	
			
		}			
		
		return mv;
	}	

	// 입양 완료된 동물 조회
	@RequestMapping(value="selectAdoptedPet")
	public ModelAndView selectAdoptedPet(ModelAndView mv) {
		
		return mv;
	}

}
