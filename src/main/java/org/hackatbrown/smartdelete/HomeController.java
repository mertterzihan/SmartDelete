package org.hackatbrown.smartdelete;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dropbox.core.DbxAppInfo;
import com.dropbox.core.DbxAuthFinish;
import com.dropbox.core.DbxClient;
import com.dropbox.core.DbxEntry;
import com.dropbox.core.DbxEntry.WithChildren;
import com.dropbox.core.DbxException;
import com.dropbox.core.DbxRequestConfig;
import com.dropbox.core.DbxUrlWithExpiration;
import com.dropbox.core.DbxWebAuthNoRedirect;
import com.dropbox.core.DbxWriteMode;

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
    List<DBXFile> list;
    
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
	
	@RequestMapping(value="/main", method = RequestMethod.POST)
	public String authorize(@RequestParam("authCode") String code, Model model) throws DbxException{

		DbxAuthFinish authFinish = webAuth.finish(code);
		client = new DbxClient(config, authFinish.accessToken);
		System.out.println(client.getAccountInfo().displayName);
		DecimalFormat df = new DecimalFormat("#.##");
		long capacity = client.getAccountInfo().quota.total;
		long usedspace = client.getAccountInfo().quota.normal;
		long freespace = capacity - usedspace;
		
		model.addAttribute("capacity", capacity/(1024.0*1024));
		model.addAttribute("usedspace", df.format(usedspace/(1024.0*1024)));
		model.addAttribute("freespace", df.format(freespace/(1024.0*1024)));
		
        System.out.println("Files in the root path:");
        //File target = new File("out.json");
        //OutputStream out = new FileOutputStream(target);
        list = getMetaData(client, "/");
        Collections.sort(list, dbxEntryComparater);
        for (DBXFile file : list) {
			System.out.println(file.getPath() + " | " + file.getDate() + " | " + file.getSize());
		}
        List<DBXFile> listToShow = list;
        if(list.size() > 10){
        	listToShow = list.subList(0, 10);
        }
        
        System.out.println(listToShow.get(0).getPath());
        
        if(listToShow != null)
			model.addAttribute("instances", listToShow);
		
		return "main";
		
	}
	
	@RequestMapping(value = "/fileupload", method = RequestMethod.GET)
	public String fileupload(Locale locale, Model model) {
		return "fileupload";
	}

	public static class CustomComparator implements Comparator<DBXFile> {

		@Override
		public int compare(DBXFile arg0, DBXFile arg1) {
			return arg0.getDate().compareTo(arg1.getDate());
		}
    }
    
    private static CustomComparator dbxEntryComparater = new CustomComparator();
    private static List<DBXFile> getMetaData(DbxClient client, String currentRoot) throws DbxException{
    	List<DBXFile> filesArray = new ArrayList<DBXFile>();
    	assert client.getMetadata(currentRoot).isFolder();
			WithChildren children = client.getMetadataWithChildren(currentRoot);
			for (DbxEntry childEntry : children.children) {
				if (childEntry.isFile()) {
					DbxUrlWithExpiration url = client.createTemporaryDirectUrl(childEntry.asFile().path);
					String path = childEntry.asFile().path;
					String size = childEntry.asFile().humanSize;
					Date date = childEntry.asFile().lastModified;
					DBXFile file = new DBXFile(url.url, date, size, path);
					filesArray.add(file);
				} else if (childEntry.isFolder()) {
					filesArray.addAll(getMetaData(client, childEntry.path));
				}
			}

			return filesArray;
    }
    
    @RequestMapping(value="/main", method = RequestMethod.GET)
    public String delete(@RequestParam("file") String path, Model model) throws DbxException{
    	
    	System.out.println(path);
    	client.delete(path);
    	
    	int i = 0;
    	Iterator<DBXFile> it = list.iterator();
    	while(it.hasNext()){
    		DBXFile current = it.next();
    		if(current.getPath().equals(path)){
    			break;
    		} else {
    			i++;
    		}
    	}
    	list.remove(i);
    	
    	List<DBXFile> listToShow = list;
    	if(listToShow.size() > 10){
    		listToShow = list.subList(0, 10);
    	}
    	
    	if(listToShow != null)
			model.addAttribute("instances", listToShow);
    	
    	DecimalFormat df = new DecimalFormat("#.##");
    	
    	long capacity = client.getAccountInfo().quota.total;
		long usedspace = client.getAccountInfo().quota.normal;
		long freespace = capacity - usedspace;
		
		model.addAttribute("capacity", capacity/(1024.0*1024));
		model.addAttribute("usedspace", df.format(usedspace/(1024.0*1024)));
		model.addAttribute("freespace", df.format(freespace/(1024.0*1024)));
    	
    	return "main";
    }
    
    @RequestMapping(value = "/fileupload", method = RequestMethod.POST)
    public String upload(@RequestParam("file") String name, Model model) throws DbxException, IOException{
    	File inputFile = new File(name);
    	FileInputStream inputStream = new FileInputStream(inputFile);
    	try {
    		DbxEntry.File uploadedFile = client.uploadFile("/" + name,
  	        DbxWriteMode.add(), inputFile.length(), inputStream);
    		System.out.println("Uploaded: " + uploadedFile.toString());
    	} finally {
    		inputStream.close();
    	}
    	
    	return "fileupload";
    }	
}
