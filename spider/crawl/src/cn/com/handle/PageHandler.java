package cn.com.handle;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import cn.com.crawl.CrawlCore;
import cn.com.item.PageItem;

public class PageHandler extends CrawlCore {

	private PageItem pageItem;

	public PageItem getPageItem() {
		return pageItem;
	}

	public void setPageItem(PageItem pageItem) {
		this.pageItem = pageItem;
	}

	@Override
	public void handleEachPage(String tempurl, String code, String textFileName)
			throws IOException {
		// TODO Auto-generated method stub

		// create a new file
		File file = new File(textFileName);
		if (!file.exists()) {
			file.createNewFile();
		}

		BufferedWriter outputBuffer = new BufferedWriter(new FileWriter(file));

		URL url = null;
		BufferedReader breader = null;
		InputStream is = null;
		// StringBuffer resultBuffer = new StringBuffer();
		try {
			url = new URL(tempurl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			is = conn.getInputStream();
			breader = new BufferedReader(new InputStreamReader(is, code));
			String line = "";
			while ((line = breader.readLine()) != null) {
				// resultBuffer.append(line);
				// System.out.println(line);
				outputBuffer.append(line);
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} finally {
			outputBuffer.close();
			breader.close();
			is.close();
		}

	}

	/**
	 * function: by topic words input : key words String; dir String; output :
	 * isFinished boolean;
	 * 
	 * @throws IOException
	 */
	public boolean getTopicWordsHtmlFile(String keyWords, String dir,String fullURL)
			throws IOException {
		boolean isFinished = false;
		File dirFile = new File(dir);

		// if not exist, create new directory
		if (!dirFile.exists() || !dirFile.isDirectory()) {
			dirFile.mkdir();
		}

		String topicFileName = dirFile.getAbsolutePath() + "/" + keyWords;
		File keyWordsFile = new File(topicFileName);
		
		// clustered by topic words
		if (!keyWordsFile.exists()) {
			keyWordsFile.mkdir();
		}

		String fileName = keyWordsFile + "/number="
				+ (keyWordsFile.listFiles().length + 1) + "keyword=" + keyWords
				+ "&page=1.html";
		// crawl the webpage and download them
		this.getHTML(fullURL, "utf-8", fileName);
		isFinished = true;
		return isFinished;
	}



}
