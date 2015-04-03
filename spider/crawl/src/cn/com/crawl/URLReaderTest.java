package cn.com.crawl;


import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.htmlparser.Node;
import org.htmlparser.Parser;
import org.htmlparser.filters.CssSelectorNodeFilter;
import org.htmlparser.filters.TagNameFilter;
import org.htmlparser.nodes.TagNode;
import org.htmlparser.tags.LinkTag;
import org.htmlparser.tags.TableTag;
import org.htmlparser.util.NodeIterator;
import org.htmlparser.util.NodeList;
import org.htmlparser.util.ParserException;
import org.htmlparser.visitors.TextExtractingVisitor;

import com.sun.org.apache.xml.internal.security.signature.NodeFilter;
import com.sun.org.apache.xpath.internal.operations.Div;


public class URLReaderTest {
	
	  private static String ENCODE = "GBK";
	    private static void message( String szMsg ) {
	       System.out.println(szMsg);
	    }

	/*
	 * public static void main(String[] args) { try { // PageHandler fileControl
	 * = new PageHandler(); // //fileControl.getHTML( // //
	 * "http://www.taobao.com", "UTF-8","~/Desktop/test.html"); // //FileControl
	 * fileControl = new FileControl(); // System.out.println("1"); //
	 * fileControl.getTopicWordsHtmlFile("test", "/home/zhihan/Desktop/test");
	 * // //// //// //// //crawl the webpage and download them ////
	 * fileControl.searchTargetKeyWords("test","/test.html"); } catch (Exception
	 * e) { e.printStackTrace(); } }
	 */
	public static void main(String[] args) throws ParserException {

/*		try{
		 Parser parser = new Parser();
		 URL url = new URL("http://www.bing.com/search?q=11");
		 HttpURLConnection con = (HttpURLConnection)url.openConnection();
		 parser.setConnection(con);
	
		 
		 TextExtractingVisitor visitor = new TextExtractingVisitor();

		parser.visitAllNodesWith(visitor);
        String textInPage = visitor.getExtractedText();
        
     //   message(textInPage);
        
        for (NodeIterator i = parser.elements (); i.hasMoreNodes(); ) {
            Node node = i.nextNode();
            message("getText:"+node.getText());
            message("getPlainText:"+node.toPlainTextString());
            message("toHtml:"+node.toHtml());
            message("toHtml(true):"+node.toHtml(true));
            message("toHtml(false):"+node.toHtml(false));
            message("toString:"+node.toString());
            message("=================================================");
        }            
		}catch(Exception e){
			e.printStackTrace();
		}
*/
		 
		   String resource = "http://www.bing.com/search?q=11";
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
	        	}
	}

}