package cn.dfx.share_record_SSM.dsum.util;

import static org.junit.Assert.*;

import java.net.URL;

import javax.servlet.Filter;

import org.junit.Before;
import org.junit.Test;

public class CharacterEncodingFilterTest {

	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		URL url = Filter.class.getProtectionDomain().getCodeSource().getLocation();  
	    System.out.println("path:"+url.getPath()+"  name:"+url.getFile());  
	}

}
