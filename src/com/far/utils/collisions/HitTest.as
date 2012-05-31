/*
* Author: Richard Lord
* Copyright (c) Richard Lord 2007
* http://www.richardlord.net/
* 
* 碰撞检测类
*/

package  com.far.utils.collisions
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;		
	
	public class HitTest 
	{
		/**
		 *两个矩阵是否重叠 
		 * @param r1
		 * @param r2
		 * @return 
		 * 
		 */		
		public static function hitTestRect( r1:Rectangle, r2:Rectangle ):Boolean
		{
			return r1.top < r2.bottom && r1.bottom > r2.top
				&& r1.left < r2.right && r1.right > r2.left;
		}
		
		/**
		 *两个对象是否重叠 
		 * @param d1
		 * @param d2
		 * @return 
		 * 
		 */		
		public static function hitTestObject( d1:DisplayObject, d2:DisplayObject ):Boolean
		{
			if( !d1.hitTestObject( d2 ) )
			{
				return false;
			}
			var bounds:Rectangle = d1.getRect( d1 );
			var bmd:BitmapData = new BitmapData( bounds.width, bounds.height, false, 0 );
			
			var matrix:Matrix = d1.transform.matrix.clone();
			matrix.translate( -bounds.left, -bounds.top );
			bmd.draw( d1, matrix, new ColorTransform( 0, 0, 0, 0, 255, 0, 0, 255 ) );
			
			matrix = d2.transform.matrix.clone();
			matrix.translate( -bounds.left, -bounds.top );
			bmd.draw( d2, matrix, new ColorTransform( 0, 0, 0, 0, 0, 0, 255, 255 ), BlendMode.ADD );
			
			var rect:Rectangle = bmd.getColorBoundsRect( 0xFFFFFF, 0xFF00FF );
			return rect.width > 0;
		}
	}
}