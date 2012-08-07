package com.far.utils.manager
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;

	/**
	 * _stage          确保在最底层。如果其下还有容器，点击不会穿透
	 *_careClasses 关注的应为_stage的子级，不是孙级, 关注的对象层级越少越好
	 * @author Administrator
	 *
	 */
	public class InteractiveManager
	{
		//关注的类
		private var _careClasses:Array;
		private var _stage:DisplayObjectContainer;

		public function InteractiveManager()
		{
			careClasses=[];
		}

		public function set careClasses(value:Array):void
		{
			_careClasses=value;
		}

		public function addCareClass(cls:Class):void
		{
			_careClasses.push(cls);
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
				if (_careClasses.indexOf(obj["constructor"]) != -1)
				{
					var drawbitmapData:BitmapData;
					if (bits is Bitmap)
					{
						drawbitmapData=(bits as Bitmap).bitmapData;
					}
					else
					{
						drawbitmapData=new BitmapData(obj.width, obj.height, true, 0);
						drawbitmapData.draw(obj);
					}
					var loaclPoint:Point=obj.globalToLocal(point);
					if (drawbitmapData.getPixel(loaclPoint.x, loaclPoint.y) != 0x00)
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
				else
				{
					obj.dispatchEvent(new MouseEvent(eventtype, true, true));
					break;
				}
			}

			var newtime:Number=getTimer();
			trace(newtime - oldTime);
		}

	}
}
