package com.kh.viewnimal.common.listener;

import java.util.ArrayList;

import javax.servlet.ServletContext;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import com.kh.viewnimal.common.model.dto.Trie;
import com.kh.viewnimal.common.model.service.CommonService;


// servletListener
@Component
public class ViewnimalServletListener implements ApplicationListener<ContextRefreshedEvent>{
	
	private Thread daemonThread = null; //쓰레드 선언
    @Autowired
    private CommonService commonService;
    @Autowired
    private ServletContext sharingContext;	//모든 서블릿에서 트리 객체 공유를 위해
	
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		//컨텍스트 로더 세팅 끝났을 시
		System.out.println("컨텍스트 로더 세팅 끝");
		/*event.getApplicationContext().
		sharingContext = event.getServletContext();*/	
		daemonThread = new Thread(new TrieThread());
		daemonThread.setDaemon(true);
		daemonThread.start();
	}

	
	class TrieThread implements Runnable{ 
		
		private Trie trie;
		
		public TrieThread(){
			this.trie = new Trie();
		}	
		
		@Override
		public void run() {
			System.out.println("데몬 쓰레드 실행");	
			//DB에 연결해서 값을 넣어야 되는 부분					
			ArrayList<String> channelTitleList = commonService.selectChannelTitleList();
			ArrayList<String> freeBoardTitleList = commonService.selectFreeBoardTitleList();
			ArrayList<String> volunteerApplyTitleList = commonService.selectVolunteerApplyTitleList();
			ArrayList<String> volunteerEpilogueTitleList = commonService.selectVolunteerEpilogueTitleList();
			
			addListToTrie(channelTitleList);	
			addListToTrie(freeBoardTitleList);
			addListToTrie(volunteerApplyTitleList);
			addListToTrie(volunteerEpilogueTitleList);
			
			sharingContext.setAttribute("trie", trie);
			
		}
		
		public void addListToTrie(ArrayList<String> list){
			if(list != null){
				for(int i=0; i < list.size(); i++){
					trie.addWord(list.get(i));
				}
			}
		}
		
	}	
}
