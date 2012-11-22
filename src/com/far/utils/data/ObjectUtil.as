package com.far.utils.data
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
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
		public static function deepClone(source:Object):*
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
		 * 浅复制一个对象<br/>
		 * 对象浅度复制 : 将实例及子实例的所有成员(属性和方法, 静态的除外)都复制一遍, (引用不必重新分配空间!)
		 * 
		 * @param	obj
		 * @return
		 */
		static public function clone(obj:*):*
		{
			if (obj == null
				|| obj is Class
				|| obj is Function
				|| isPrimitiveType(obj))
			{
				return obj;
			}
			
			var xml:XML = describeType(obj);
			var o:* = new (Object(obj).constructor as Class);
			// clone var variables
			for each(var key:XML in xml.variable)
			{
				o[key.@name] = obj[key.@name];
			}
			// clone getter setter, if the accessor is "readwrite" then set this accessor.
			for each(key in xml.accessor)
			{
				if("readwrite" == key.@access)
					o[key.@name] = obj[key.@name];
			}
			// clone dynamic variables
			for (var k:String in obj)
			{
				o[k] = obj[k];
			}
			return o;
		}
		
		/**
		 * 测试是否为原始类型 , Booelan, Number, String
		 * @param	o
		 * @return
		 */
		static public function isPrimitiveType(o:*):Boolean
		{
			return o is Boolean || o is Number || o is String;
		}
		
		
		
		/**
		 * 绑定一个对象的值到另一个对象
		 *
		 * @param	obj
		 * @return
		 */
		static public function bind(source:*,target:*):void
		{
			
			var xml:XML=describeType(source);
			// clone var variables
			for each (var key:XML in xml.variable)
			{
				if(target[key.@name])
					target[key.@name]=source[key.@name];
			}
			// clone getter setter, if the accessor is "readwrite" then set this accessor.
			for each (key in xml.accessor)
			{
				if ("readwrite" == key.@access&&target[key.@name])
					target[key.@name]=source[key.@name];
			}
			// clone dynamic variables
			for (var k:String in source)
			{
				if(target[k])
					target[k]=source[k];
			}
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

