package org.hackatbrown.smartdelete;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dropbox.core.DbxAppInfo;
import com.dropbox.core.DbxAuthFinish;
import com.dropbox.core.DbxClient;
import com.dropbox.core.DbxException;
import com.dropbox.core.DbxRequestConfig;
import com.dropbox.core.DbxWebAuthNoRedirect;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
		
	final String APP_KEY = "m5bfnmik40esq18";
    final String APP_SECRET = "cj4iixfkh6sgs1x";
    DbxWebAuthNoRedirect webAuth;
    DbxRequestConfig config;
    DbxClient client;
    
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		DbxAppInfo appInfo = new DbxAppInfo(APP_KEY, APP_SECRET);

        config = new DbxRequestConfig(
            "SmartDelete\1.0", Locale.getDefault().toString());
        webAuth = new DbxWebAuthNoRedirect(config, appInfo);
		//webAuth = new DbxWebAuthRedirect(conifg, appInfo)l
        
        String authorizeUrl = webAuth.start();
        
		model.addAttribute("authorizeUrl", authorizeUrl );
		
		return "home";
	}
	
	@RequestMapping(value="/", method = RequestMethod.POST)
	public String authorize(@RequestParam("authCode") String code) throws DbxException{

		DbxAuthFinish authFinish = webAuth.finish(code);
		client = new DbxClient(config, authFinish.accessToken);
		System.out.println(client.getAccountInfo().displayName);
		
		return "main";
		
	}
	
	@RequestMapping(value = "/fileupload", method = RequestMethod.GET)
	public String fileupload(Locale locale, Model model) {
		return "fileupload";
	}
}
