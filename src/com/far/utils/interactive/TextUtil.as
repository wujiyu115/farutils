package com.far.utils.interactive
{
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class TextUtil
	{
		/** 获取文本格式 默认12字体白色*/
		public static function getTextFormat(size:int=12, color:int=0xffffff):TextFormat
		{
			var tf:TextFormat=new TextFormat();
			tf.size=size;
			tf.color=color;
			tf.font="Arial";
			tf.bold;
			return tf;
		}

		/**
		 *得到特定颜色的html文字
		 * @param fontSize
		 * @param fontColor
		 * @param string
		 * @return
		 *
		 */
		public static function getHtmlText(fontSize:int, fontColor:String, string:String):String
		{
			return ((((((("<font size='" + fontSize) + "' color='") + fontColor) + "'>") + string) + "</font>"));
		}
		
		/**
		 * 中文文本 只能输入中文的文本
		 * @param variable 要格式化的文本
		 * 
		 */
		public static function ChineseText(variable:TextField):void{
			variable.restrict="一-龥";
		}
		/**
		 * 非符号的文本 只能输入除符号外的文本
		 * @param variable 要格式化的文本
		 * 
		 */
		public static function signText(variable:TextField):void{
			variable.restrict="ˆa-z 0-9 一-龥 A-Z";
		}
		/**
		 * 数字文本 只能输入数字的文本
		 * @param variable 要格式化的文本
		 * 
		 */
		public static function numberText(variable:TextField):void{
			variable.restrict="0-9";
		}
		/**
		 * 字母文本 只能输入大小写字母的文本
		 * @param variable 要格式化的文本
		 * 
		 */
		public static function letterText(variable:TextField):void{
			variable.restrict="a-z A-Z";
		}
		/**
		 * 小写字母文本 只能输入小写字母的文本
		 * @param variable 要格式化的文本
		 * 
		 */
		public static function smallLetterText(variable:TextField):void{
			variable.restrict="a-z";
		}
		/**
		 * 大写字母文本 只能输入大写字母的文本
		 * @param variable 要格式化的文本
		 * 
		 */
		public static function bigLetterText(variable:TextField):void{
			variable.restrict="A-Z";
		}
		/**
		 * 获得字符串所占字节数
		 * @param	_str	要计算的字符串
		 * @param	isutf8	是否UTF8编码
		 */ 
		public static function getStrLen(_str:String,isutf8:Boolean=true):uint
		{
			var _len:uint = 0;
			for (var _p:uint = 0; _p<_str.length; _p++)
			{
				_len += _str.charCodeAt(_p)>255 ? (isutf8?3:2) : 1;
			}
			return _len;
		}
		
	}
}