package   com.far.utils.load
{

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLLoader;
	
	/**
	 * ...
	 * @author WZH(shch8.com)
	 */
	public class NetBag 
	{
		
		/**
		 * XML或者txt文件加载
		 * @param	filePath	文件路径
		 * @param	callback	回调函数,如果加载XML,函数参数为XML,如function getXML(xml:XML)
		 * @param	gbCode		是否使用中文编码,默认是
		 * @param	useXML		是否返回XML格式,默认是
		 * @return  URLLoader
		 */
		public final function loadXML(filePath:String, callback:Function = null,gbCode:Boolean=true,useXML:Boolean=true):URLLoader
		{
			return NetLoad.getInstance().loadXML(filePath, callback, gbCode, useXML);
		}
		/**
		 * 加载外部文件，jpg,png,gif图片及SWF文件
		 * @param	filePath	文件路径
		 * @param	callback	回调函数,参数为Loader对象,如:function getLoader(value:Loader):void{}
		 * @return	Loader
		 */
		public final function loadFile(filePath:String, callback:Function = null):Loader
		{
			return NetLoad.getInstance().loadFile(filePath, callback);
		}
		
	
	}
	
}