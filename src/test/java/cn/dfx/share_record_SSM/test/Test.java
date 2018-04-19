package cn.dfx.share_record_SSM.test;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;


public class Test {
	
	public void test(){
		URL url = Filter.class.getProtectionDomain().getCodeSource().getLocation();  
	    System.out.println("path:"+url.getPath()+"  name:"+url.getFile());  
	}
}
