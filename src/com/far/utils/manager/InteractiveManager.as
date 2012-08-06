package com.far.utils.manager
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;

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
		}

		protected function clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			if(!event.cancelable)
			check(event.type);
		}

		public function check(eventtype:String):void
		{
			var point:Point=new Point(_stage.stage.mouseX, _stage.stage.mouseY);
			//最底层mc的在数组最前面  ,这个点应该是全局坐标,呃返回的是bitmap数组
			var array:Array=_stage.getObjectsUnderPoint(point);
			var i:int=array.length;
			if (!i)
				return;
			while (i--)
			{
				var obj:DisplayObject=array[i];
				if (_careClasses.indexOf(array[i].constructor) != -1)
				{
					var drawbitmapData:BitmapData=new BitmapData(obj.width, obj.height, true, 0);
					drawbitmapData.draw(obj);
					var loaclPoint:Point=obj.globalToLocal(point);
					if (drawbitmapData.getPixel(loaclPoint.x, loaclPoint.y) != 0x00)
					{
						obj.dispatchEvent(new MouseEvent(eventtype,true,true));
						drawbitmapData.dispose();
						break;
					}
					drawbitmapData.dispose();
				}
				else
				{
					obj.dispatchEvent(new MouseEvent(eventtype,true,true));
					break;
				}
			}

		}

	}
}
