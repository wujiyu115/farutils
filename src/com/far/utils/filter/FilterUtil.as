package com.far.utils.filter
{
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;

	public class FilterUtil
	{
		/** 获取发光滤镜 默认黄色*/
		public static function glowFilter(color:int=0xfcfc00, alpha:Number=0.7, blurX:uint=11, blurY:uint=11, strength:Number=2):GlowFilter
		{
			var glow:GlowFilter=new GlowFilter();
			glow.color=color;
			glow.alpha=alpha;
			glow.blurX=blurX; //水平模糊量
			glow.blurY=blurY; //垂直模糊量
			glow.quality=BitmapFilterQuality.MEDIUM; //应用滤镜2次
			glow.strength=strength;
			return glow;
		}

		/**使mc变灰*/
		public static function grayFilter(mc:DisplayObject):void
		{
			mc.filters=[new ColorMatrixFilter([0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1])]
		}
	}
}
