package   com.far.utils.data
{
	
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.system.ApplicationDomain;
import flash.utils.getQualifiedClassName;
/**
 * 
 * @author lake
 * 
 */
public class Reflection
{
	/**
	 * 
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
	 * 
	 * @param fullClassName
	 * @return 
	 * 
	 */	
	public static function createDisplayObjectBitmap(fullClassName:String):Bitmap
	{
		var displayObject:DisplayObject = createDisplayObjectInstance(fullClassName);
		var bitmapData:BitmapData=new BitmapData(displayObject.width, displayObject.height,true,0xffffff);
		bitmapData.draw(displayObject);
		var bitmap:Bitmap=new Bitmap(bitmapData);
		return bitmap;
	}	
	/**
	 * 
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
	 * 
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
	 * 
	 * @param o
	 * @return 
	 * 
	 */	
	public static function getFullClassName(o:*):String
	{
		return getQualifiedClassName(o);
	}
	/**
	 * 
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