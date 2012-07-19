package com.far.utils.file
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class ReadText
	{
		/**
		 *写入文本到内存字节流 
		 * @param dst
		 * @param val
		 * @param length
		 * @return 
		 * 
		 */		
		public static function writeStringToByteArray(dst:ByteArray,val:String,length:uint=0):uint
		{
			var tmp:ByteArray = newLitteEndianByteArray();
			tmp.writeMultiByte(val, "utf-8");
			if(length != 0)
				tmp.length = length;
			dst.writeBytes(tmp);
			
			return tmp.length;
		}
		/**
		 *读取文本从内存字节流 
		 * @param dst
		 * @param length
		 * @return 
		 * 
		 */		
		public static function readStringByByteArray(dst:ByteArray,length:uint):String
		{
			var tmp:ByteArray = newLitteEndianByteArray();
			dst.readBytes(tmp, 0, length);		
			return tmp.readMultiByte(length, "utf-8");
		}
		/**
		 *获取文本字节长度 
		 * @param val
		 * @return 
		 * 
		 */		
		public static function getStringByteLength(val:String):uint
		{
			var tmp:ByteArray = newLitteEndianByteArray();
			tmp.writeMultiByte(val, "utf-8");
			return tmp.length;
		}	
		
		public static function newLitteEndianByteArray():ByteArray
		{
			var result:ByteArray = new ByteArray;
			result.endian = Endian.LITTLE_ENDIAN;
			return result;
		}
	}
}