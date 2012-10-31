package com.far.utils.filter
{
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;

	public class FilterUtil
	{
		
		
		//公用一个浮雕滤镜 不必重复创建
		private static var convolArray:Array = [new ConvolutionFilter(3, 3, [-2, -1, 0, -1, 1, 1, 0, 1, 2])];
		//公用一个胶片滤镜 不必重复创建
		private static var digitalArray:Array = [new ColorMatrixFilter([-1, 0, 0, 0, 255, 0, -1, 0, 0, 255, 0, 0, -1, 0, 255, 0, 0, 0, 1, 0])];
		//公用一个灰度滤镜 不必重复创建
		private static var graysArray:Array = [new ColorMatrixFilter([0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0, 0, 0, 1, 0])];

		
		
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

	
		/**
		 * 实现冰蓝效果
		 * @param display 目标显示对象
		 */
		public static function frostEffect(display:DisplayObject):void{
			var colorInfo:ColorTransform = display.transform.colorTransform;
			colorInfo.redOffset = 0;
			colorInfo.greenOffset = 30;
			colorInfo.blueOffset = 150;
			display.transform.colorTransform = colorInfo;
		}
		
		/**
		 * 实现火红效果
		 * @param display 目标显示对象
		 */ 
		public static function burnEffect(display:DisplayObject):void{
			var colorInfo:ColorTransform = display.transform.colorTransform;
			colorInfo.redOffset = 100;
			colorInfo.greenOffset = 0;
			colorInfo.blueOffset = 0;
			display.transform.colorTransform = colorInfo;
		}
		
		/**
		 * 实现叶绿效果
		 * @param display 目标显示对象
		 */
		public static function cruelEffect(display:DisplayObject):void{
			var colorInfo:ColorTransform = display.transform.colorTransform;
			colorInfo.redOffset = 0;
			colorInfo.greenOffset = 120;
			colorInfo.blueOffset = 0;
			display.transform.colorTransform = colorInfo;
		}
		
		/**
		 * 实现增白效果
		 * @param display 目标显示对象
		 */
		public static function knockEffect(display:DisplayObject):void{
			var colorInfo:ColorTransform = display.transform.colorTransform;
			colorInfo.redOffset = 120;
			colorInfo.greenOffset = 120;
			colorInfo.blueOffset = 120;
			display.transform.colorTransform = colorInfo;
		}
		
		/**
		 * 实现泛黄效果
		 * @param display 目标显示对象
		 */
		public static function hitEffect(display:DisplayObject):void{
			var colorInfo:ColorTransform = display.transform.colorTransform;
			colorInfo.redOffset = 80;
			colorInfo.greenOffset = 80;
			colorInfo.blueOffset = 0;
			display.transform.colorTransform = colorInfo;
		}
		
		/**
		 * 实现泛黑效果
		 * @param display 目标显示对象
		 */
		public static function dizzyEffect(display:DisplayObject):void{
			var colorInfo:ColorTransform = display.transform.colorTransform;
			colorInfo.redOffset = -80;
			colorInfo.greenOffset = -80;
			colorInfo.blueOffset = -80;
			display.transform.colorTransform = colorInfo;
		}
		
		/**
		 * 浮雕效果
		 * @param display 目标显示对象
		 */ 
		public static function convolEffect(display:DisplayObject):void{
			display.filters = convolArray;
		}
		
		/**
		 * 胶片效果
		 * @param display 目标显示对象
		 */ 
		public static function digitalEffect(display:DisplayObject):void{
			display.filters = digitalArray;
		}
		
		/**
		 * 灰度效果
		 * @param display 目标显示对象
		 */ 
		public static function graysEffect(display:DisplayObject):void{
			display.filters = graysArray;
		}
	}
}
