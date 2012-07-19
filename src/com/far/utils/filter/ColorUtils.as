package com.far.utils.filter
{

	/**
	 * 颜色工具类
	 * @author lxh
	 *
	 */
	public class ColorUtils
	{
		static public function getHex(cr:Number=0, cg:Number=0, cb:Number=0, ca:Number=0):Number
		{
			var cr:Number=(cr > 1) ? 1 : cr;
			var cg:Number=(cg > 1) ? 1 : cg;
			var cb:Number=(cb > 1) ? 1 : cb;
			var ca:Number=(ca > 1) ? 1 : ca;

			return Math.round(ca * 255) << 24 ^ Math.round(cr * 255) << 16 ^ Math.round(cg * 255) << 8 ^ Math.round(cb * 255);
		}

		/**
		* Returns an Object with the r, g and b values from 0 to 1
		* @param	hexColor	Hexadecimal value
		*/
		static public function getRGB(hexColor:Number):Object
		{
			var rgbColor:Object=new Object();
			rgbColor.a=((0xFF0000 & hexColor) >> 24) / 0xff;
			rgbColor.r=((0xFF0000 & hexColor) >> 16) / 0xff;
			rgbColor.g=((0x00FF00 & hexColor) >> 8) / 0xff;
			rgbColor.b=(0x0000FF & hexColor) / 0xff;

			return rgbColor;
		}

		public function HSB2RGB(hue:Number, sat:Number, val:Number):Object
		{
			var red:Number;
			var grn:Number;
			var blu:Number;
			var i:Number;
			var f:Number;
			var p:Number;
			var q:Number;
			var t:Number;

			hue%=360;

			if (val == 0)
				return ({r: 0, g: 0, b: 0});

			sat/=100;
			val/=100;
			hue/=60;
			i=Math.floor(hue);
			f=hue - i;
			p=val * (1 - sat);
			q=val * (1 - (sat * f));
			t=val * (1 - (sat * (1 - f)));

			switch (i)
			{
				case 0:
					red=val;
					grn=t;
					blu=p;
					break;
				case 1:
					red=q;
					grn=val;
					blu=p;
					break;
				case 2:
					red=p;
					grn=val;
					blu=t;
					break;
				case 3:
					red=p;
					grn=q;
					blu=val;
					break;
				case 4:
					red=t;
					grn=p;
					blu=val;
					break;
				case 5:
					red=val;
					grn=p;
					blu=q;
					break;
			}

			return ({r: red, g: grn, b: blu});
		}

		public function RGB2HSB(red:Number, grn:Number, blu:Number):Object
		{
			var x:Number;
			var val:Number;
			var f:Number;
			var i:Number;
			var hue:Number;
			var sat:Number;

			x=Math.min(Math.min(red, grn), blu);
			val=Math.max(Math.max(red, grn), blu);

			if (x == val)
				return ({h: undefined, s: 0, v: val * 100});

			f=(red == x) ? grn - blu : ((grn == x) ? blu - red : red - grn);
			i=(red == x) ? 3 : ((grn == x) ? 5 : 1);
			hue=Math.floor((i - f / (val - x)) * 60) % 360;
			sat=Math.floor(((val - x) / val) * 100);
			val=Math.floor(val * 100);
			return ({h: hue, s: sat, b: val});
		}

		public static function rgbaToHex(red:int, green:int, blue:int, alpha:int):uint
		{
			return alpha << 24 ^ red << 16 ^ green << 8 ^ blue;
		}

		public static function rgbToHex(red:int, green:int, blue:int):uint
		{
			return red << 16 ^ green << 8 ^ blue;
		}

		public static function hexToRgba(color:uint):Object
		{
			var result:Object={};

			result.alpha=(color >> 24) & 0xFF;
			result.red=(color >> 16) & 0xFF;
			result.green=(color >> 8) & 0xFF;
			result.blue=color & 0xFF;

			return result;
		}

		public static function hexToRgb(color:uint):Object
		{
			var result:Object={};

			result.red=(color >> 16) & 0xFF;
			result.green=(color >> 8) & 0xFF;
			result.blue=color & 0xFF;

			return result;
		}

		public static function hexToFloat3(color:uint):Array
		{
			var result:Array=[];

			result[0]=(color >> 16) & 0xFF;
			result[1]=(color >> 8) & 0xFF;
			result[2]=color & 0xFF;

			return result;
		}

		public static function interpolateColorsRgb(color1:uint, color2:uint, amount:Number):uint
		{
			var color1Rgba:Object=hexToRgb(color1);
			var color2Rgba:Object=hexToRgb(color2);

			var resultRgb:Object=new Object();

			resultRgb.red=color1Rgba.red * (1 - amount) + color2Rgba.red * amount;
			resultRgb.green=color1Rgba.green * (1 - amount) + color2Rgba.green * amount;
			resultRgb.blue=color1Rgba.blue * (1 - amount) + color2Rgba.blue * amount;

			return rgbToHex(resultRgb.red, resultRgb.green, resultRgb.blue);
		}

		public static function interpolateColorsRgba(color1:uint, color2:uint, amount:Number):uint
		{
			var color1Rgba:Object=hexToRgba(color1);
			var color2Rgba:Object=hexToRgba(color2);

			var resultRgb:Object=new Object();

			resultRgb.red=color1Rgba.red * (1 - amount) + color2Rgba.red * amount;
			resultRgb.green=color1Rgba.green * (1 - amount) + color2Rgba.green * amount;
			resultRgb.blue=color1Rgba.blue * (1 - amount) + color2Rgba.blue * amount;
			resultRgb.alpha=255;

			return rgbaToHex(resultRgb.red, resultRgb.green, resultRgb.blue, resultRgb.alpha);
		}

		/**
		 * ARGB颜色值转换为RGB颜色值
		 * @param	argb:uint —— 一个正整数值，ARGB所表示的颜色值
		 * @return 	uint —— 一个正整数值，RGB所表示的颜色值
		 */
//		public static function getRGB(argb:uint):uint
//		{
//			return (0xFFFFFF & argb);
//		}

		/**
		 * RGB颜色值转换为ARGB颜色值
		 * @param	rgb:uint —— 一个正整数值，RGB所表示的颜色值
		 * @param	alpha:uint —— 一个正整数值，转换成ARGB所需增加的Alpha通道值
		 * @return 	uint —— 一个正整数值，ARGB所表示的颜色值
		 */
		public static function getARGB(rgb:uint, alpha:uint=0xFF):uint
		{
			return (alpha << 24) | rgb;
		}

		/**
		 * 从ARPG颜色值中获取Alpha通道的颜色值
		 * @param	argb:uint —— 一个正整数值，ARPG所表示的颜色值
		 * @return	uint —— 一个正整数值，ARPG颜色值中Alpha通道所表示的颜色值
		 */
		public static function getAlpha(argb:uint):uint
		{
			return (argb >> 24) & 0xFF;
		}

		/**得到一个随机颜色*/
		public static function getRandomColor():uint
		{
			return Math.random() * uint.MAX_VALUE;
		}
	}
}
