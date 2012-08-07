package com.far.utils.manager
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;

	/**
	 * _stage          确保在最底层。如果其下还有容器，点击不会穿透
	 * @author Administrator
	 *
	 */
	public class InteractiveManager
	{
		private var _stage:DisplayObjectContainer;
		public function InteractiveManager()
		{
		}
		public function initStage(stage:DisplayObjectContainer):void
		{
			_stage=stage;
			_stage.addEventListener(MouseEvent.CLICK, clickHandler, true);
			_stage.addEventListener(MouseEvent.CLICK, clickHandlerPop);
		}

		protected function clickHandlerPop(event:MouseEvent):void
		{
			trace(event.target);
		}

		protected function clickHandler(event:MouseEvent):void
		{
			if (!event.cancelable)
			{
				event.stopImmediatePropagation();
				check(event.type);
			}
		}

		public function check(eventtype:String):void
		{
			var oldTime:Number=getTimer();
			var point:Point=new Point(_stage.stage.mouseX, _stage.stage.mouseY);
			//最底层mc的在数组最前面  ,这个点应该是全局坐标,呃返回的是bitmap数组
			var array:Array=_stage.getObjectsUnderPoint(point);
			var i:int=array.length;
			if (!i)
				return;
			while (i--)
			{
				var obj:DisplayObject=array[i];
				var bits:DisplayObject=array[i];
				while (obj.parent != _stage)
				{
					obj=obj.parent;
				}
				var drawbitmapData:BitmapData;
				if (bits is Bitmap)
				{
					drawbitmapData=(bits as Bitmap).bitmapData;
				}
				else
				{
					drawbitmapData=new BitmapData(bits.width, bits.height, true, 0);
					drawbitmapData.draw(bits);
				}
				var loaclPoint:Point=obj.globalToLocal(point);
				if (drawbitmapData.getPixel32(loaclPoint.x, loaclPoint.y) != 0x00)
				{
					obj.dispatchEvent(new MouseEvent(eventtype, true, true));
					break;
				}
				if (!(bits is Bitmap))
				{
					drawbitmapData.dispose();
					drawbitmapData=null;
				}
			}

			var newtime:Number=getTimer();
			trace(newtime - oldTime);
		}

	}
}
