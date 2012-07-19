package com.far.utils.displayobject
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**闪动的mc 需要两帧*/
	
	public class FlashButtonUtil
	{
		private var timer:Timer;
		private var button:MovieClip;

		public function FlashButtonUtil(button:MovieClip, time:Number=500)
		{
		 
			this.button=button;
			timer=new Timer(time);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
			button.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			button.addEventListener(MouseEvent.MOUSE_OUT, overHandler);
		}

		protected function overHandler(event:MouseEvent):void
		{

			switch (event.type)
			{
				case MouseEvent.MOUSE_OVER:
				{
					timer.reset();
					button.gotoAndStop(2);
					break;
				}
				case MouseEvent.MOUSE_OUT:
				{
					timer.start();
					button.gotoAndStop(1);
					break;
				}


			}

		}

		protected function timerHandler(event:TimerEvent):void
		{
		 
			if (button.currentFrame == 1)
			{
				button.gotoAndStop(2);
			}
			else
			{
				button.gotoAndStop(1);
			}
		}
		


		public function remove():void
		{
			button.removeEventListener(MouseEvent.MOUSE_OVER, overHandler);
			button.removeEventListener(MouseEvent.MOUSE_OUT, overHandler);
			if (timer.running)
			{
				timer.stop();
			}
			timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			timer = null;
		}
	}
}
