package app.activity.thanksgiving.v
{
	import com.far.utils.filter.FilterUtil;
	
	import flash.display.InteractiveObject;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 *
	 * Program Name:       BlankButtonUtil
	 * @author             wujiyu
	 * @email              wujiyu115@gmail.com
	 * @version            1.0
	 * Time:               2012-11-13 下午7:40:32
	 */
	public class BlankButtonUtil
	{
		private var _clearIn:int;
		private var _timeout:int;
		private var _btn:SimpleButton;
		private var _downHandler:Function;
		

		public function BlankButtonUtil(btn:SimpleButton,downHandler:Function, timeout:int=1000)
		{
			this._btn=btn;
			this._timeout=timeout;
			this._downHandler = downHandler;
		}

		protected function mouseDownHandler(event:MouseEvent):void
		{
			_downHandler(event);
			enableBtn(_btn, false);
			clearTimeout(_clearIn);
			_clearIn=setTimeout(function():void
				{
					enableBtn(_btn, true);
				}, _timeout);

		}

		private function enableBtn(btn:InteractiveObject, enable:Boolean):void
		{
			btn.mouseEnabled=enable;
			enable ? btn.filters=[] : FilterUtil.graysEffect(btn);
		}
		
		
		public function dispose():void{
			clearTimeout(_clearIn);
			this._btn.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_btn= null;
			_downHandler= null;
		}
		
		public function clear():void{
			clearTimeout(_clearIn);
			this._btn.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		public function start():void{
			this._btn.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}

	}
}