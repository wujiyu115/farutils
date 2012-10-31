package com.far.utils.effect
{
	/**
	 *
	 * Program Name:       BitmapFrame
	 * @author             wujiyu
	 * @email              wujiyu115@gmail.com
	 * @version            1.0
	 * Time:               2012-10-29 下午8:17:41
	 */
	import com.far.utils.displayobject.DrawShape;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Transform;
	import flash.utils.Dictionary;
	
	import org.superkaka.kakalib.struct.BitmapFrameInfo;
	import org.superkaka.kakalib.utils.BitmapCacher;

	public class ImageDistortion extends Sprite
	{
		private var dic:Dictionary;
		//导弹速度
		private var speedBomb:Number=15;
		//导弹转角速度
		private var omega:Number=10;
		private var bombs:Array=[];
		private var target:Sprite;
		public function ImageDistortion()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			
		}
		
		protected function addToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			init();
		}
		
		private function init():void
		{
			var mc:ImageMetital=new ImageMetital();
			dic=conver(mc,10);
			var bitmapinfo:BitmapFrameInfo = dic[0];
			for (var i:int = 0; i < 1; i++)
			{
				bombs[i] = new ImageDistortionObject();
				bombs[i].bitmapData = bitmapinfo.bitmapData;
				bombs[i].x = Math.random()*stage.stageWidth;
				bombs[i].y = Math.random()*stage.stageHeight;
				addChild(bombs[i]);
			}
			target = DrawShape.createCircle(30,30,30);
			target.x = Math.random()*stage.stageWidth;
			target.y = Math.random()*stage.stageHeight;
			addChild(target);
			var arr:Array=[];
			for  (var j:String in dic)
			{
				arr.push(int(j));
			}
//			trace(arr.sort(Array.NUMERIC));
			this.addEventListener(Event.ENTER_FRAME, enterFramHandler);
		}


		public function conver(mc:MovieClip, everyrotation:int=10):Dictionary
		{
			var dic:Dictionary=new Dictionary();
			var i:int=0;
			var c:int=int(360 / everyrotation);
			var transform:Transform=mc.transform;
			var container:Sprite=new Sprite();
			container.addChild(mc);
			while (i < c)
			{
				var ro:int=i * everyrotation;
				mc.rotation=ro;
				var bit:BitmapFrameInfo=BitmapCacher.cacheBitmap(container, true);
				dic[ro]=bit;
				i++;
			}
			mc.transform=transform;
			return dic;
		}
		
		
		private function find(bomb:ImageDistortionObject, target:DisplayObject):void
		{
			//牛b ,打中了
			if (bomb.hitTestObject(target))
			{
				return;
			}
			var x:Number=bomb.x - target.x;
			var y:Number=bomb.y - target.y;
			
			var angle:Number=(270 + Math.atan2(y, x) * 180 / Math.PI) % 360;
			var angleC:Number=(angle - bomb.rotation + 360) % 360;
			var dir:Number=angleC < 180 ? 1 : -1;
			if (angleC < 180 && angleC > omega || angleC > 180 && 360 - angleC > omega)
			{
				bomb.rotation=bomb.rotation + omega * dir;
//				bomb.dirction=bomb.dirction + omega * dir;
//				var finddir:int =bomb.dirction>=0?bomb.dirction:360+bomb.dirction;
//				trace(finddir);
//				if( dic[finddir])
//				bomb.bitmapData = dic[finddir].bitmapData;
			}
			else
			{
				bomb.rotation=angle;
//				
//				if( dic[finddir])
//				bomb.bitmapData = dic[finddir].bitmapData;
			}
			bomb.dirction=bomb.rotation;
			var finddir:int =bomb.dirction>=0?bomb.dirction:360+bomb.dirction;
			trace(finddir);
			bomb.x+=speedBomb * Math.sin(bomb.rotation * Math.PI / 180);
			bomb.y-=speedBomb * Math.cos(bomb.rotation * Math.PI / 180);
		}

		protected function enterFramHandler(event:Event):void
		{
			for (var i:int=bombs.length - 1; i >= 0; i--)
			{
				find(bombs[i],target );
			}
//			var ba:BitmapFrameInfo=all[count] as BitmapFrameInfo
//			bitmap.bitmapData=ba.bitmapData;
//			bitmap.x=ba.x;
//			bitmap.y=ba.y;
//			count++;
//			if (count == all.length - 1)
//				count=0;
		}
	}
}
import flash.display.Bitmap;

class ImageDistortionObject extends Bitmap
{
	private var _dirction:int;
	private var _realRotation:Number=0;

	public function get realRotation():Number
	{
		return _realRotation;
	}

	public function set realRotation(value:Number):void
	{
		_realRotation = value;
	}

	public function get dirction():int
	{
		return _dirction;
	}

	public function set dirction(value:int):void
	{
		_dirction=int(value / 10) * 10;
	}
}