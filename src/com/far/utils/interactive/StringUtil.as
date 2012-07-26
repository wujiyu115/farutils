
package com.far.utils.interactive
{

	/**
	 *	字符串工具类
	 */

	public class StringUtil
	{


		/**
		*	比较两个字符串相等
		*/
		public static function stringsAreEqual(s1:String, s2:String, caseSensitive:Boolean):Boolean
		{
			if (caseSensitive)
			{
				return (s1 == s2);
			}
			else
			{
				return (s1.toUpperCase() == s2.toUpperCase());
			}
		}

		/**
		*	去掉两边空格
		*/
		public static function trim(input:String):String
		{
			return StringUtil.ltrim(StringUtil.rtrim(input));
		}

		/**
		*	去掉左空格
		*/
		public static function ltrim(input:String):String
		{
			var size:Number=input.length;
			for (var i:Number=0; i < size; i++)
			{
				if (input.charCodeAt(i) > 32)
				{
					return input.substring(i);
				}
			}
			return "";
		}

		/**
		*	去掉右空格
		*/
		public static function rtrim(input:String):String
		{
			var size:Number=input.length;
			for (var i:Number=size; i > 0; i--)
			{
				if (input.charCodeAt(i - 1) > 32)
				{
					return input.substring(0, i);
				}
			}

			return "";
		}

		/**
		*	以什么开头
		*/
		public static function beginsWith(input:String, prefix:String):Boolean
		{
			return (prefix == input.substring(0, prefix.length));
		}

		/**
		*	以什么结尾
		*/
		public static function endsWith(input:String, suffix:String):Boolean
		{
			return (suffix == input.substring(input.length - suffix.length));
		}

		/**
		*	移除指定的全部
		*/
		public static function remove(input:String, remove:String):String
		{
			return StringUtil.replaceAll(input, remove, "");
		}

		/**
		*	替换全部
		*/
		public static function replaceAll(input:String, replace:String, replaceWith:String):String
		{
			return input.split(replace).join(replaceWith);
		}

		/**替换flash中TextField中的/r */
		public static function replaceAutoWarp(input:String):String
		{
			return replaceAll(input, "\r", "");
		}


		/**
		*	是否有值
		*/
		public static function stringHasValue(s:String):Boolean
		{
			//todo: this needs a unit test
			return (s != null && s.length > 0);
		}

		/**
		 *	是否是字母
		 */
		public static function isLetter(chars:String):Boolean
		{
			if (chars == null || chars == "")
			{
				return false;
			}
			for (var i:int=0; i < chars.length; i++)
			{
				var code:uint=chars.charCodeAt(i);
				if (code < 65 || code > 122 || (code > 90 && code < 97))
				{
					return false;
				}
			}
			return true;
		}
	}
}
