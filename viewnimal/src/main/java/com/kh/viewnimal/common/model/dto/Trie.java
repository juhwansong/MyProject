package com.kh.viewnimal.common.model.dto;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;

import lombok.Setter;
@Setter
public class Trie {

	private TrieNode root;  //모든 가지의 뿌리가 되는 루트노드
	private int kewordCount = 0;
	private static final char[] CHO = 
	    {0x3131, 0x3132, 0x3134, 0x3137, 0x3138, 0x3139, 0x3141, 
	        0x3142, 0x3143, 0x3145, 0x3146, 0x3147, 0x3148, 
	        0x3149, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e};
	private static final char[] JUN =
		{0x314f, 0x3150, 0x3151, 0x3152, 0x3153, 0x3154, 0x3155, 
		        0x3156, 0x3157, 0x3158, 0x3159, 0x315a, 0x315b, 
		        0x315c, 0x315d, 0x315e, 0x315f, 0x3160, 0x3161,    
		        0x3162, 0x3163};
	private static final char[] JON =
		{0x0000, 0x3131, 0x3132, 0x3133, 0x3134, 0x3135, 0x3136, 
		        0x3137, 0x3139, 0x313a, 0x313b, 0x313c, 0x313d, 
		        0x313e, 0x313f, 0x3140, 0x3141, 0x3142, 0x3144, 
		        0x3145, 0x3146, 0x3147, 0x3148, 0x314a, 0x314b, 
		        0x314c, 0x314d, 0x314e};
	//문자열 추가
	public void addWord(String word){
		if(root == null){ //루트 노드가 없으면 공백값을 갖고 있는 루트노드 생성(모든 자식 노드들의 뿌리)-루트 노드를 기준으로 뿌리를 뻗어나가는 구조		
			root = new TrieNode(' ');
		}
		TrieNode start = root; //루트 노드가 있으면 루트노드부터 시작
	
		ArrayList<Character> charecters = new ArrayList<>();
		
		for(int i=0; i< word.length(); i++){
			char comVal = (char) (word.charAt(i));
			
			if(comVal >= 0xAC00){	//해당 문자가 한글일때 (노드에 한글 문자 하나를 초성 중성 종성으로 쪼개서 넣음)
				char uniVal = (char)(comVal-0xAC00);
				
				char cho = (char) (((uniVal - (uniVal % 28))/28)/21);
                char jun = (char) (((uniVal - (uniVal % 28))/28)%21);
                char jon = (char) (uniVal %28);
                                                        
                charecters.add(CHO[cho]);
                
			  
                charecters.add(JUN[jun]);
				
                if((char)jon != 0x0000){
                charecters.add(JON[jon]);
                }
					
					
			}
			else{
				// 한글이 아니거나 초성 하나일 경우				
				charecters.add(word.charAt(i));
			}
		}
		for(int i=0; i< charecters.size(); i++){
			if( start.getChilds().size() == 0){ //루트 노드가 갖고있는 자식노드가 없을 경우	
				TrieNode newNode = new TrieNode(charecters.get(i)); //해당 문자 값을 갖는 노드 객체 생성
				start.getChilds().put(charecters.get(i), newNode); //생성한 노드 객체를 자식노드에 추가
				start = newNode; //노드객체를 갖고 있는 start변수가 추가한 자식 노드 객체를 가르키게
			}
			else{
				TrieNode node=null; //자식 노드 객체 하나를 담기 위한 변수
				
				if(start.getChilds().get(charecters.get(i)) != null){ //해당 문자값을 갖고 있는 자식 노드가 있으니 start변수가 그 자식 노드를 가르키게(자식 노드의 자식 노드를 계속 참조해가면서 문자 값 비교 후 삽입하는 방식)
					node = start.getChilds().get(charecters.get(i));
					start = node;
				}
				else{ //해당 문자값을 갖고 있는 자식 노드가 없으니 생성하고 자식노드에 추가 후 start변수가 추가 한 자식 노드를 가르키게	
					TrieNode newNode = new TrieNode(charecters.get(i)); 
					start.getChilds().put(charecters.get(i), newNode);	
					start = newNode;	
				}
			}
			if(i+1 == charecters.size()){//i가 charecters배열의 마지막 인덱스일 경우
				start.setEndFlag(true); //addword한 키워드의 마지막 문자라는걸 명시하기 위해 
			}
		}
		for(char c : charecters){
			if( start.getChilds().size() == 0){ //루트 노드가 갖고있는 자식노드가 없을 경우	
				TrieNode newNode = new TrieNode(c); //해당 문자 값을 갖는 노드 객체 생성
				start.getChilds().put(c, newNode); //생성한 노드 객체를 자식노드에 추가
				start = newNode; //노드객체를 갖고 있는 start변수가 추가한 자식 노드 객체를 가르키게
			}
			else{
				TrieNode node=null; //자식 노드 객체 하나를 담기 위한 변수
				
				if(start.getChilds().get(c) != null){ //해당 문자값을 갖고 있는 자식 노드가 있으니 start변수가 그 자식 노드를 가르키게(자식 노드의 자식 노드를 계속 참조해가면서 문자 값 비교 후 삽입하는 방식)
					node = start.getChilds().get(c);
					start = node;
				}
				else{ //해당 문자값을 갖고 있는 자식 노드가 없으니 생성하고 자식노드에 추가 후 start변수가 추가 한 자식 노드를 가르키게	
					TrieNode newNode = new TrieNode(c); 
					start.getChilds().put(c, newNode);	
					start = newNode;	
				}
			}
		}		
	}
	
	//매치되는 값이 있는지 검색
	public List search(String prefix){
		if(prefix == null || prefix.isEmpty() || root == null){ //입력한 키워드가 없으면 null을 리턴
			return null;
		}
		ArrayList<Character> chars = new ArrayList<>();
		
		for(int i=0; i< prefix.length(); i++){
			
			char comVal = (char) (prefix.charAt(i));
			
			if (comVal >= 0xAC00){	//해당 문자가 한글일때
				char uniVal = (char)(comVal-0xAC00);
				char cho = (char) (((uniVal - (uniVal % 28))/28)/21);
                char jun = (char) (((uniVal - (uniVal % 28))/28)%21);
                char jon = (char) (uniVal %28);
                              
                chars.add(CHO[cho]);
				          
                chars.add(JUN[jun]);
				
                if((char)jon != 0x0000){
				chars.add(JON[jon]);
				}		
			}
			else{
				// 한글이 아니거나 초성 하나일 경우								
				chars.add(prefix.charAt(i));
			}
		}
	
		TrieNode start = root; //루트 노드부터 검색 시작
		boolean flag = false; //flag 초기값을 false로 설정
		for(char c : chars){
			flag = false; // 자식 노드 마다 해당 키워드의 문자가 있는지 확인해야 되기 때문(현재 노드가 해당 문자값을 갖고 있어도 현재 노드의 자식 노드가 다음 문자값을 갖고 있지 않을 겨우가 있기때문)
			if(start.getChilds().size() > 0){ //루트 노드가 자식 노드를 갖고 있다면	
				if(start.getChilds().get(c) != null){
					start = start.getChilds().get(c); //자식 노드를 start 변수가 가르키게
					flag = true; //해당 값을 찾았으니 flag 값을 true로
				}
			}
			if(flag == false){ //루트 노드가 자식 노드를 갖고 있지 않거나 해당 문자 값을 갖고 있는 자식 노드가 없을때 			
				break; //값이 없기 때문에 for문을 나감
			}
		}
		if(flag){ //값이 있을때		
			List matches = getAllWords(start,prefix); //입력한 키워드 문자열이 포함된 문자열들을 반환하는 메소드
			return matches;
		}
		
		return null;
	}
	
	
	private List<String> getAllWords(TrieNode start,final String prefix){
		
		List<String> list = new LinkedList();
		
		
		if(start.isEndFlag()){ //입력한 키워드의 마지막 문자와 일치한 노드의 endFlag값이 true일때(endFlag=true는 문자열의 끝임을 의미)
			this.kewordCount++;
			list.add(prefix);  //endFlag를 설정 안해주면 addword한 키워드가 {"자바","자바코드"}일때 "자바"는 저장 못함(문자열의 끝이라는걸 모르기 때문)
		}
		if(start.getChilds().size() == 0){ //입력한 키워드와 일치 한 노드가 자식노드들이 없을때 (일치 하는 값이 키워드와 동일한 문자열 값 딱 하나이므로)
			return list;
		}
		else{ //입력한 키워드와 일치 한 노드가 자식노드들이 있을때(키워드에 접미사가 붙은 문자열들이 있을때)
			for(Entry<Character, TrieNode> n: start.getChilds().entrySet()){	
				//자동완성 목록 리스트 개수가 10개면(여기서 리스트 갯수 변경 가능)
				if(this.kewordCount == 10){
					return list;
				}
				list.addAll(getAllWords(n.getValue(), prefix + n.getValue().getCharacter())); //getAllWords메소드 반환값(list객체)을 list객체를 담는 변수 list에 전부 넣기(값이 여러개라 addAll)
				
			}	
			return list;
		}
		
	}
	
}