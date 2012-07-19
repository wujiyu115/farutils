package com.far.utils.expression
{
	import flash.geom.Point;

	public class ExpressionUtil
	{

		/**转弧度*/
		public static function toRadian(angle:Number):Number
		{
			return angle * Math.PI / 180;
		}

		/**转角度*/
		public static function toAngle(radian:Number):Number
		{
			return radian * 180 / Math.PI;
		}

		/**得到两点间的值*/
		public static function distance(one:Point, two:Point):Number
		{
			var xpo:Number=one.x - two.x;
			var ypo:Number=one.y - two.y;
			return Math.sqrt(Math.pow(xpo, 2) + Math.pow(ypo, 2));
		}
	}
}
