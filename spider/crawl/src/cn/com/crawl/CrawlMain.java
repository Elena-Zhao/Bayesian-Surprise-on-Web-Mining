package cn.com.crawl;

import java.io.IOException;
import java.util.List;

import org.htmlparser.util.ParserException;

import cn.com.handle.PageHandler;
import cn.com.handle.ResultListHandler;

public class CrawlMain {

	public static final String DIR = "/home/zhihan/Desktop/results";
	public ResultListHandler resultListHandler = new ResultListHandler();
	public PageHandler pageHandler = new PageHandler();
	
	String[] keywords  = {"test","Obama","English","disease","development","java","valuable person","political","China","America"};
	
	public CrawlMain() {
		
	}

	public void startCrawl(){
		try {
			for(int i=0;i<keywords.length;i++){
				this.crawlOneKeyWord(keywords[i]);
			}
		} catch (ParserException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//爬取一个关键字的结果
	public void crawlOneKeyWord(String keyword) throws ParserException, IOException {
		for (int i = 0; i < 10; i++) {
			String resource = this.getUrlOfGoogle(keyword, i + 1);
			List<String> links = resultListHandler.getAllResultLinks(resource);
			for(int j=0; j<links.size();j++){
				pageHandler.getTopicWordsHtmlFile(keyword,DIR+"/",links.get(j));
			}
		}
	}

	// get the url through key word
	public String getUrlOfGoogle(String keyWords, int page) {
		return "http://www.bing.com/search?q=" + keyWords + "&first=" + page
				+ "1";
	}
	
	

}
