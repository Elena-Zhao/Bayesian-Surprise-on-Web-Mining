package cn.com.crawl;

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

import cn.com.dispose.ErrorDispose;

public abstract class CrawlCore {

	/**
	 * 
	 * Description: 获取指定URL的内容
	 * 
	 * @Version1.0 2012-6-1 下午02:18:22 by Zhihan创建
	 * @param tempurl
	 *            url地址
	 * @param code
	 *            url页面编码
	 * @return
	 * @throws IOException
	 */
	public boolean getHTML(String tempurl, String code, String textFileName)
			throws IOException {
		// if file name is null, print the error
		// 如果文件名为空，返回
		if (textFileName == null) {
			ErrorDispose.outputError("NULL STRING");
			return false;
		}

		try {
			this.handleEachPage(tempurl, code, textFileName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}

	public abstract void handleEachPage(String tempurl, String code,
			String textFileName) throws Exception;


	
}
