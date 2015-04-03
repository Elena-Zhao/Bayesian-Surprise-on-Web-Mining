package cn.com.handle;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.htmlparser.Parser;
import org.htmlparser.filters.CssSelectorNodeFilter;
import org.htmlparser.filters.TagNameFilter;
import org.htmlparser.tags.LinkTag;
import org.htmlparser.util.NodeList;
import org.htmlparser.util.ParserException;

import cn.com.crawl.CrawlCore;
import cn.com.item.ResultListItem;

public class ResultListHandler extends CrawlCore{
	
	
	
	

	@Override
	public void handleEachPage(String tempurl, String code, String textFileName) throws IOException {
		// TODO Auto-generated method stub
		//create a new file 
	
		
		URL url = null;
		BufferedReader breader = null;
		InputStream is = null;
		//StringBuffer resultBuffer = new StringBuffer();
		try {
			url = new URL(tempurl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			is = conn.getInputStream();
			breader = new BufferedReader(new InputStreamReader(is, code));
			String line = "";
			while ((line = breader.readLine()) != null) {
				handleEachLine(line);
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} finally {
			breader.close();
			is.close();
		}
		
	}
	
	
	//处理每一行的结果
	public void handleEachLine(String line){
		
	}
	

	
	
	
	//得到搜索结果的所有链接
	public List<String> getAllResultLinks(String resource) throws ParserException{
		  
			List<String> links = new ArrayList<String>();
			Parser myParser = new Parser(resource);

	        // 设置编码
	        myParser.setEncoding("UTF-8");
	       
	        CssSelectorNodeFilter cssFilter = new CssSelectorNodeFilter("ol[id='b_results'] li[class='b_algo'] h2 a");
	        String filterStr = "a";
	        TagNameFilter filter = new TagNameFilter(filterStr);
	        
	        
	        NodeList nodeList = myParser.extractAllNodesThatMatch(cssFilter);
	     
	        for(int i=0;i<nodeList.size();i++){
	        	 LinkTag n1=(LinkTag)nodeList.elementAt(i);
	        	String s=n1.extractLink();
	  
	        //处理每个页面上的搜索结果
	        	System.out.println(s);
	        	links.add(s);
	        	}
	        
	        return links;
	}
}
