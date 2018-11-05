package com.kh.viewnimal.common.model.dto;

import java.util.HashMap;


public class TrieNode {
	
	private char character;
	private HashMap<Character,TrieNode> childs;
	private boolean endFlag = false;
	
	public TrieNode(char charecter) {
		this.character = charecter;
		this.childs = new HashMap<>();
	}

	public char getCharacter() {
		return character;
	}
	public void setCharacter(char character) {
		this.character = character;
	}
	public HashMap<Character,TrieNode> getChilds() {
		return childs;
	}
	public void setChilds(HashMap<Character,TrieNode> childs) {
		this.childs = childs;
	}
	public boolean isEndFlag() {
		return endFlag;
	}
	public void setEndFlag(boolean endFlag) {
		this.endFlag = endFlag;
	}	
}

