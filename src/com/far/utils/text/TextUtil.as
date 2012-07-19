package com.far.utils.text
{
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
	}
}