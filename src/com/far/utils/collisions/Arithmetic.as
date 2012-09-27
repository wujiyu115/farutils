package  com.far.utils.collisions
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * Arithmetic 游戏算法
	 * @author smallpeak QQ:547243998
	 * @langversion 3.0
	 * @playerversion Flash 9
	 */
	public class Arithmetic
	{

		/**
		 * 寻找显示对象的绝对位置。
		 * @param sprite 显示对象
		 * @return 位置
		 */		
		public static function findScreenPosition(sprite:DisplayObject):Point
		{
			if (!sprite) return null;
			
			var result_x:Number=sprite.x;
			var result_y:Number=sprite.y;
			
			var _parent:DisplayObject = sprite.parent
			while (_parent)
			{
				result_x = result_x+_parent.x;
				result_y = result_y+_parent.y;
				_parent = _parent.parent
			}
			return new Point(result_x,result_y);
		}
		/**
		 * 旋转角度
		 * @param mouse 鼠标的坐标Point
		 * @param mc 要旋转的对象
		 * @return 旋转角度
		 */		
		public static function indicatorRotation(mouse:Point,mc:DisplayObjectContainer):Number{
			var distanceX:Number= mouse.x - mc.x;
			var distanceY:Number= mouse.y - mc.y;
			return Math.atan2(distanceX,distanceY) * 180 / Math.PI;
		}
		/**
		 * 箭矢的抛物线运动
		 * @param obj 包括(mouse:Point(目标x,目标y),rotation:弓箭初始旋转度,speed:力度
		 * @param mc 箭矢对象(中心点必须为居中)
		 * @param parabolas 抛物线
		 * @return  运行该算法的函数
		 */		
		public static function parabola(obj:Object,mc:DisplayObjectContainer,parabolas:Boolean=true):Function
		{
			mc.rotation = obj.rotation;//初始化子弹旋转位置
			var distanceX:Number = obj.mouse.x - mc.x;//x距离
			var distanceY:Number = obj.mouse.y - mc.y;//y距离
			if(!parabolas){//不用抛物线，直接到达目标
				obj.speed = Math.sqrt(distanceX * distanceX + distanceY * distanceY) / 10;	
			}
			var angle:Number = obj.rotation * Math.PI / 180;//角度
			var speedX:* = Math.cos(angle) * obj.speed;
			var speedY:* = Math.sin(angle) * (-obj.speed);
			function frame():void
			{
				var oriX:Number= mc.x;//记录前一个x位置
				var oriY:Number= mc.y;//记录前一个y位置
				mc.x +=  speedX;
				mc.y -=  speedY;
				mc.rotation = Math.atan2(mc.y - oriY,mc.x - oriX) * 180 / Math.PI;//现在的角度
				speedY -=  0.9;
			}
			return frame
		}
		/**
		 * 绘制扇形
		 * @param mc 扇形所在影片剪辑的名字
		 * @param x 扇形原点的x坐标
		 * @param y 扇形原点的y坐标
		 * @param r 扇形的半径
		 * @param angle 扇形的角度
		 * @param startFrom 扇形的起始角度
		 * @param color 扇形的颜色
		 */		
		public static function DrawSector(mc:*,x:Number=200,y:Number=200,r:Number=100,angle:Number=27,startFrom:Number=270,color:Number=0xff0000):void
		{
			mc.graphics.clear();
			mc.graphics.beginFill(color,50);
			mc.graphics.lineStyle(0,0xff0000);
			mc.graphics.moveTo(x,y);
			angle=(Math.abs(angle)>360)?360:angle;
			var n:Number = Math.ceil(Math.abs(angle) / 45);
			var angleA:Number = angle / n;
			angleA = angleA * Math.PI / 180;
			startFrom = startFrom * Math.PI / 180;
			mc.graphics.lineTo(x+r*Math.cos(startFrom),y+r*Math.sin(startFrom));
			for (var i:int=1; i<=n; i++)
			{
				startFrom +=  angleA;
				var angleMid:* = startFrom - angleA / 2;
				var bx:* =x+r/Math.cos(angleA/2)*Math.cos(angleMid);
				var by:* =y+r/Math.cos(angleA/2)*Math.sin(angleMid);
				var cx:*  = x + r * Math.cos(startFrom);
				var cy:*  = y + r * Math.sin(startFrom);
				mc.graphics.curveTo(bx,by,cx,cy);
			}
			if (angle!=360)
			{
				mc.graphics.lineTo(x,y);
			}
			mc.graphics.endFill();
		}
		/**
		 * 移动到某个位置 
		 * @param oneself 要移动的对象
		 * @param target 目标位置
		 * @param speed 速度
		 */		
		public static function moveTo(oneself:DisplayObject,targetPoint:Point,speed:Number):Boolean{
			var dy:Number=targetPoint.y-oneself.y;
			var dx:Number=targetPoint.x-oneself.x;
			var angle:Number=Math.atan2(dy,dx);
			if(dy*dy+dx*dx>speed*speed){
				oneself.x += speed*Math.cos(angle);
				oneself.y += speed*Math.sin(angle);
				return true
			}
			return  false;
		}
		
		/**
		 *导弹追踪算法  
		 * @param bomb
		 * @param player
		 * 
		 */		
		public static function bombFllow(bomb:Object,player:Object):void{
			var omega:int =5 ;//导弹转角速度
			var speedBomb:int =10 ;//导弹速度
			var x : Number = bomb.x - player.x;
			var y : Number = bomb.y - player.y;
			
			var angle : Number = (270 + Math.atan2(y, x) * 180 / Math.PI) % 360;
			var angleC : Number = (angle - bomb.rotation + 360) % 360;
			var dir : Number = angleC < 180 ? 1 : -1;
			if (angleC < 180 && angleC > omega  || angleC > 180 && 360 - angleC > omega)
			{
				bomb.rotation = bomb.rotation + omega * dir;
			}
			else
			{
				bomb.rotation = angle;
			}
			bomb.x += speedBomb * Math.sin(bomb.rotation * Math.PI / 180);
			bomb.y -= speedBomb* Math.cos(bomb.rotation * Math.PI / 180);     
		}
	}   
}