package com.far.utils.displayobject
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class DrawShape
	{
		
		/**
		 *画圆 
		 * @param x
		 * @param y
		 * @param radius
		 * @param color
		 * @return 
		 * 
		 */		
		public static function createCircle( x:Number, y:Number, radius:Number,color:uint=0x000000):Sprite
		{
			var sprite:Sprite=new Sprite();
			var gr:Graphics=sprite.graphics;
			gr.beginFill(color);
			gr.drawCircle(x, y, radius);
			return sprite;
		}
		
		/**
		 * 根据传入的目标graphics进行绘制同心的圆形
		 **/
		public static function drawConCircle(graphics:Graphics,x:Number,y:Number,radiusMin:Number,radiusMax:Number,color:uint = 0,alpha:Number = 1):void{
			graphics.clear();
			graphics.beginFill(color,alpha);
			graphics.drawCircle(x, y, radiusMin); //绘制同心圆的时候公共部分会挖掉 形成中空的效果
			graphics.drawCircle(x, y, radiusMax);
			graphics.endFill();
		}
		
		/**
		 * 根据传入的目标graphics进行绘制等边三角形
		 **/
		public static function drawTriangle(graphics:Graphics,x:Number,y:Number,radius:Number,color:uint = 0,alpha:Number = 1):void{
			graphics.clear();
			drawRegularPolygon( graphics, x, y, 3, radius, color, alpha);
		}
		
		/**
		 * 根据传入的目标graphics进行绘制正多变形 x,y 表示圆心点位置
		 * */
		public static function drawRegularPolygon(graphics:Graphics,x:Number,y:Number,
												  sides:uint,radius:Number,color:uint = 0,alpha:Number = 1):void{
			if(sides < 3){
				throw(new Error("绘制正多变形不能小于三边！"));
				return;
			}
			var angle:Number = 360 / sides; //算出切散角
			graphics.clear();
			graphics.beginFill(color,alpha); //先填充
			for(var i:uint = 0 ; i < sides ; i++){
				var tarX:Number = radius * Math.sin(angle * i / 180 * Math.PI) + x ; //带入公式 r * sinO + px
				var tarY:Number = -radius * Math.cos(angle * i / 180 * Math.PI) + y ; //带入公式 r * cosO + py
				if(i == 0){
					graphics.moveTo(tarX,tarY);
				}else{
					graphics.lineTo(tarX,tarY);
				}
			}
			graphics.endFill(); //结束填充
		}
		
		/**
		 * 根据传入的目标graphics进行绘制正星形 x,y表示圆心点位置
		 * */
		public static function drawStar(g:Graphics, x:Number, y:Number, sides:int, minR:Number, maxR:Number, color:uint = 0, alpha:uint = 0):void
		{
			g.clear();
			g.beginFill(color);
			var angle:Number = 360 / sides; // 每次旋转角度
			for(var i:int = 0; i < sides + 1; i++)
			{
				var curAngle:Number = angle * i; // 当前角度
				var minX:Number = Math.cos((curAngle + angle * 0.5)/180*Math.PI) * minR + x; // 每次是当前角度 + 间隔角度的一半
				var minY:Number = Math.sin((curAngle + angle * 0.5)/180*Math.PI) * minR + y;
				var maxX:Number = Math.cos(angle*i/180*Math.PI) * maxR + x;
				var maxY:Number = Math.sin(angle*i/180*Math.PI) * maxR + y;
				if(i == 0)
				{
					g.moveTo(maxX,maxY);
					g.lineTo(minX,minY);
				}
				else
				{
					g.lineTo(maxX,maxY);
					g.lineTo(minX,minY);
				}
			}
			g.endFill();
		}
		
		/**
		 * 画斑马线
		 * 
		 * @param	graphics	<b>	Graphics</b> 
		 * @param	beginPoint	<b>	Point	</b> 
		 * @param	endPoint	<b>	Point	</b> 
		 * @param	width		<b>	Number	</b> 斑马线的宽度
		 * @param	grap		<b>	Number	</b> 
		 */
		static public function drawZebraStripes(graphics:Graphics, beginPoint:Point, endPoint:Point, width:Number, grap:Number):void
		{
			if (!graphics || !beginPoint || !endPoint || width <= 0 || grap <= 0) return;
			
			var Ox:Number = beginPoint.x;
			var Oy:Number = beginPoint.y;
			
			var totalLen:Number = Point.distance(beginPoint, endPoint);
			var currLen:Number = 0;
			var halfWidth:Number = width * .5;
			
			var radian:Number = Math.atan2(endPoint.y - Oy, endPoint.x - Ox);
			var radian1:Number = (radian / Math.PI * 180 + 90) / 180 * Math.PI;
			var radian2:Number = (radian / Math.PI * 180 - 90) / 180 * Math.PI;
			
			var currX:Number, currY:Number;
			var p1x:Number, p1y:Number;
			var p2x:Number, p2y:Number;
			
			while (currLen <= totalLen)
			{
				currX = Ox + Math.cos(radian) * currLen;
				currY = Oy + Math.sin(radian) * currLen;
				p1x = currX + Math.cos(radian1) * halfWidth;
				p1y = currY + Math.sin(radian1) * halfWidth;
				p2x = currX + Math.cos(radian2) * halfWidth;
				p2y = currY + Math.sin(radian2) * halfWidth;
				
				graphics.moveTo(p1x, p1y);
				graphics.lineTo(p2x, p2y);
				
				currLen += grap;
			}
			
		}
		
		
		/**
		 * 画虚线
		 * 
		 * @param	graphics	<b>	Graphics</b> 
		 * @param	beginPoint	<b>	Point	</b> 
		 * @param	endPoint	<b>	Point	</b> 
		 * @param	width		<b>	Number	</b> 虚线的长度
		 * @param	grap		<b>	Number	</b> 
		 */
		static public function drawDashed(graphics:Graphics, beginPoint:Point, endPoint:Point, width:Number, grap:Number):void
		{
			if (!graphics || !beginPoint || !endPoint || width <= 0 || grap <= 0) return;
			
			var Ox:Number = beginPoint.x;
			var Oy:Number = beginPoint.y;
			
			var radian:Number = Math.atan2(endPoint.y - Oy, endPoint.x - Ox);
			var totalLen:Number = Point.distance(beginPoint, endPoint);
			var currLen:Number = 0;
			var x:Number, y:Number;
			
			while (currLen <= totalLen)
			{
				x = Ox + Math.cos(radian) * currLen;
				y = Oy +Math.sin(radian) * currLen;
				graphics.moveTo(x, y);
				
				currLen += width;
				if (currLen > totalLen) currLen = totalLen;
				
				x = Ox + Math.cos(radian) * currLen;
				y = Oy +Math.sin(radian) * currLen;
				graphics.lineTo(x, y);
				
				currLen += grap;
			}
			
		}
	}
}
