package com.projectsierra.springappengine;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public final class HelloWorldController {

	@RequestMapping(value = "/springappengine",  method = RequestMethod.GET)
	public String HelloWorld() {
		return "MyView";
	}
}
