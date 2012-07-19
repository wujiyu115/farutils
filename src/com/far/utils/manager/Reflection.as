package   com.far.utils.manager
{
	
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.system.ApplicationDomain;
import flash.utils.getQualifiedClassName;
/**
 * 反射类
 * @author lake
 * 
 */
public class Reflection
{
	/**
	 * 得到显示对象
	 * @param fullClassName
	 * @param applicationDomain
	 * @return 
	 * 
	 */	
	public static function createDisplayObjectInstance(fullClassName:String,
													   applicationDomain:ApplicationDomain=null):DisplayObject
	{
		return createInstance(fullClassName, applicationDomain) as DisplayObject;
	}
	/**
	 * 得到位图
	 * @param fullClassName
	 * @return 
	 * 
	 */	
	public static function createDisplayObjectBitmap(fullClassName:String):Bitmap
	{
		var displayObject:DisplayObject = createDisplayObjectInstance(fullClassName);
		var bitmapData:BitmapData=new BitmapData(displayObject.width, displayObject.height,true,0xffffff);
		bitmapData.draw(displayObject); //draw方法。。
		var bitmap:Bitmap=new Bitmap(bitmapData);
		return bitmap;
	}	
	/**
	 * 从指定域反射类
	 * @param fullClassName
	 * @param applicationDomain
	 * @return 
	 * 
	 */	
	public static function createInstance(fullClassName:String,
										  applicationDomain:ApplicationDomain=null):*
	{
		var assetClass:Class = getClass(fullClassName, applicationDomain);
		if(assetClass != null)
		{
			return new assetClass();
		}
		return null;		
	}
	/**
	 * 得到类
	 * @param fullClassName
	 * @param applicationDomain
	 * @return 
	 * 
	 */	
	public static function getClass(fullClassName:String, applicationDomain:ApplicationDomain=null):Class
	{
		if(applicationDomain == null)
		{
			applicationDomain = ApplicationDomain.currentDomain;
		}
		try
		{
			var assetClass:Class = applicationDomain.getDefinition(fullClassName) as Class;
		}catch(e :Error)
		{
			trace(e);
		}
		return assetClass;		
	}
	/**
	 * 得到对象的类全名
	 * @param o
	 * @return 
	 * 
	 */	
	public static function getFullClassName(o:*):String
	{
		return getQualifiedClassName(o);
	}
	/**
	 * 得到实例的类名
	 * @param o
	 * @return 
	 * 
	 */	
	public static function getClassName(o:*):String
	{
		var name:String = getFullClassName(o);
		var lastI:int = name.lastIndexOf(".");
		if(lastI >= 0)
		{
			name = name.substr(lastI+1);
		}
		return name;
	}
	/**
	 *得到一个实例的包名 
	 * @param o
	 * @return 
	 * 
	 */	
	public static function getPackageName(o:*):String
	{
		var name:String = getFullClassName(o);
		var lastI:int = name.lastIndexOf(".");
		if(lastI >= 0)
		{
			return name.substring(0, lastI);
		}
		else
		{
			return "";
		}
	}
}

}