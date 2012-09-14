package com.far.utils.interactive
{
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;

	/**
	 * 
	 * Program Name:       TextFactory
	 * @author             wujiyu
	 * @email              wujiyu115@gmail.com
	 * @version            1.0
	 * Time:               2012-9-14 下午7:04:59
	 */
	public class TextFactory
	{
		/**
		 * 创建一个单行的TextLine
		 * @param $str 文本内容
		 * @param $width 文本宽度
		 * @return 单行的TextLine
		 */	
		public static function createSingleTextLine($str:String, $width:Number, $color:uint=0x000000, $size:int=12, $font:FontDescription=null):TextLine
		{
			if(!$font)
				$font = new FontDescription('Microsoft YaHei', 'bold');
			var __ef:ElementFormat = new ElementFormat($font);
			__ef.color = $color;
			__ef.fontSize = $size;
			var __tb:TextBlock = new TextBlock(new TextElement($str, __ef));
			return __tb.createTextLine(null, $width);
		}
	}
}