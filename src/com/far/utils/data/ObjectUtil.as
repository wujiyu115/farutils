package com.far.utils.data
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * ... 对象工具类 ...
	 * @author Jerry ...
	 * @version 0.1.0
	 */
	public final class ObjectUtil
	{

		/**
		 * 克隆对象（深复制）
		 * @param source:Object —— 源对象，克隆对象的主体
		 * @return * —— 源对象的克隆对象
		 */
		public static function clone(source:Object):*
		{
			var bytes:ByteArray=new ByteArray();
			var className:String=getQualifiedClassName(source);
			var cls:Class=getDefinitionByName(className) as Class;

			registerClassAlias(className, cls);
			bytes.writeObject(source);
			bytes.position=0;
			return bytes.readObject();
		}

		/**
		 * 判断对象是否为空
		 * @param	value:Object —— 被检测对象。
		 * @return	Boolean —— 布尔值，对象为空返回true；反之返回false。
		 */
		public static function isNull(value:Object):Boolean
		{
			return Boolean(value == null);
		}

		/**
		 *是否是字符串 
		 * @param value
		 * @return 
		 * 
		 */		
		public static function isString(value:*):Boolean
		{
			return (typeof(value) == "string" || value is String);
		}

		/**
		 *是滞是数字 
		 * @param value
		 * @return 
		 * 
		 */		
		public static function isNumber(value:*):Boolean
		{
			return (typeof(value) == "number" || value is Number);
		}

		/**
		 *是否是boolean值 
		 * @param value
		 * @return 
		 * 
		 */		
		public static function isBoolean(value:*):Boolean
		{
			return (typeof(value) == "boolean" || value is Boolean);
		}

		/**
		 *是不是是方法 
		 * @param value
		 * @return 
		 * 
		 */		
		public static function isFunction(value:*):Boolean
		{
			return (typeof(value) == "function" || value is Function);
		}
		
		/**
		 * int 转进制字符串
		 * @param value
		 * @return 
		 * 
		 */	
		public static function int2String(target:int,bin:int=10):String{
		  return target.toString(bin);
		}
		/**
		 * 进制字符串 int 
		 * @param value
		 * @return 
		 * 
		 */	
		public static function str2Int(str:String,bin:int=10):int{
			return parseInt(str,bin);
		}
		
	}

}

