package cn.com.item;

import java.util.List;

public class ResultListItem {
	
	
	private String topicUrl;
	private int pageNumber;
	private List<String> urls;
	private String keyWords;
	private List<PageItem> pageItems;
	
	
	
	public List<PageItem> getPageItems() {
		return pageItems;
	}
	public void setPageItems(List<PageItem> pageItems) {
		this.pageItems = pageItems;
	}
	public String getTopicUrl() {
		return topicUrl;
	}
	public void setTopicUrl(String topicUrl) {
		this.topicUrl = topicUrl;
	}
	public int getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	public List<String> getUrls() {
		return urls;
	}
	public void setUrls(List<String> urls) {
		this.urls = urls;
	}
	public String getKeyWords() {
		return keyWords;
	}
	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}
	
	
	
	

}
