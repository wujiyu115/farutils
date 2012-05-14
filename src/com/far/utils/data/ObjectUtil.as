package  com.far.utils.data
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
		public static function clone(source:Object) : *
		{
			var bytes:ByteArray = new ByteArray();
			var className:String = getQualifiedClassName(source);
			var cls:Class = getDefinitionByName(className) as Class;
			
			registerClassAlias(className, cls);
			bytes.writeObject(source);
			bytes.position = 0;
			return bytes.readObject();
		}
		
		/**
		 * 判断对象是否为空
		 * @param	value:Object —— 被检测对象。
		 * @return	Boolean —— 布尔值，对象为空返回true；反之返回false。
		 */
		public static function isNull(value:Object) : Boolean
		{
			return Boolean(value == null);
		}
		/** Checks wherever passed-in value is <code>String</code>.
			*/
			public static function isString(value:*):Boolean {
				return ( typeof(value) == "string" || value is String );
			}
			
			/**
			 * Checks wherever passed-in value is <code>Number</code>.
			 */
			public static function isNumber(value:*):Boolean {
				return ( typeof(value) == "number" || value is Number );
			}
			
			/**
			 * Checks wherever passed-in value is <code>Boolean</code>.
			 */
			public static function isBoolean(value:*):Boolean {
				return ( typeof(value) == "boolean" || value is Boolean );
			}
			
			/**
			 * Checks wherever passed-in value is <code>Function</code>.
			 */
			public static function isFunction(value:*):Boolean {
				return ( typeof(value) == "function" || value is Function );
			}
	}

}

