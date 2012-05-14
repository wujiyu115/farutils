package  com.far.utils.displayobject
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	/**
	 *  位图旋转工具类 
	 *  
	 */
	public final class BitmapUtil
	{
		/**
		 * 顺时针旋转90度
		 * @param	bmp:Bitmap —— 待旋转的位图对象
		 * @return	旋转后生成的位图数据对象
		 */
		public static function rotate90CW(bmp:Bitmap):BitmapData
		{
			var matrix:Matrix = new Matrix();
			var bmpData:BitmapData = new BitmapData(bmp.height, bmp.width, true, 0);
			matrix.rotate(Math.PI / 2);
			matrix.translate(bmp.height, 0);
			bmpData.draw(bmp, matrix);
			return bmpData;
		}
		
		/**
		 * 逆时针旋转90度
		 * @param	bmp:Bitmap —— 待旋转的位图对象
		 * @return	旋转后生成的位图数据对象
		 */
		public static function rotate90CCW(bmp:Bitmap):BitmapData
		{
			var matrix:Matrix = new Matrix();
			var bmpData:BitmapData = new BitmapData(bmp.height, bmp.width, true, 0);
			matrix.rotate(-Math.PI / 2);
			matrix.translate(0, bmp.width);
			bmpData.draw(bmp, matrix);
			return bmpData;
		}
		
		/**
		 * 水平翻转
		 * @param	bmp:Bitmap —— 待翻转的位图对象
		 * @return	翻转后的位图数据对象
		 */
		public static function horizontalFlip(bmp:Bitmap):BitmapData
		{
			var matrix:Matrix = bmp.transform.matrix.clone();
			var bmpData:BitmapData = new BitmapData(bmp.width, bmp.height, true, 0);
			matrix.a = -1;
			matrix.tx = bmp.x + bmp.width;
			bmpData.draw(bmp, matrix);
			return bmpData;
		}
		
		/**
		 * 垂直翻转
		 * @param	bmp:Bitmap —— 待翻转的位图对象
		 * @return	翻转后的位图数据对象
		 */
		public static function verticalFlip(bmp:Bitmap):BitmapData
		{
			var matrix:Matrix = bmp.transform.matrix.clone();
			var bmpData:BitmapData = new BitmapData(bmp.width, bmp.height, true, 0);
			matrix.d = -1;
			matrix.ty = bmp.y + bmp.height;
			bmpData.draw(bmp, matrix);
			return bmpData;
		}
	}

}