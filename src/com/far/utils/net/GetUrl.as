package com.far.utils.net
{
	/**
	 * ...
	 * @author wmy
	 *
	 *
	 */
	//例子:
	/*
	   new GetUrl("http://www.xxxx.com/");
	 */

	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.external.ExternalInterface;

	public class GetUrl
	{

		/**
		 *导航
		 * @param url
		 * @param window
		 * @param features
		 *
		 */
		public static function GetUrl(url:String, window:String="_blank", features:String="")
		{
			var WINDOW_OPEN_FUNCTION:String="window.open";
			var myURL:URLRequest=new URLRequest(url);
			var browserName:String=getBrowserName();

			if (getBrowserName() == "Firefox")
			{ //Firefox
				ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			}
			else if (browserName == "IE")
			{ //If IE, 
				ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			}
			else if (browserName == "Safari")
			{ //If Safari     
				navigateToURL(myURL, window);
			}
			else if (browserName == "Opera")
			{ //If Opera 
				navigateToURL(myURL, window);
			}
			else
			{
				navigateToURL(myURL, window);
			}
		}

	}
}