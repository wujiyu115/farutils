package  com.far.utils.date
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 客户端定时器
	 * @author lxh
	 * 
	 */	
	public class ClientTimer
	{
		/**
		 * timer 回调函数
		 */		
		private var _timerCallBack 	:Function;
		/**
		 *complete 回调函数 
		 */		
		private var _completeCallBack :Function;
		/**
		 * 定时器
		 */		
		private var _timer :Timer;
		
		public function ClientTimer(timer:Function,completeCall:Function)
		{
			_timerCallBack =timer;
			_completeCallBack= completeCall;
		}
		
		
		
		public function set timerCallBack(func : Function):void
		{
			_timerCallBack = func;
		}
		
		public function get timerCallBack():Function
		{
			return _timerCallBack;
		}
		
		public function set completeCallBack(func : Function):void
		{
			_completeCallBack = func;
		}
		
		public function get completeCallBack():Function
		{
			return _completeCallBack;
		}
		////////////////////////////////////////////////////
		/////方法
		
		/**
		 *开始定时器 
		 * @param delay
		 * @param repeatCount
		 * 
		 */		
		public function startTimer(delay:Number,repeatCount:int = 0):void
		{
			_timer = new Timer(delay,repeatCount);
			_timer.addEventListener(TimerEvent.TIMER,onTimer);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,onComplete);
			_timer.start();
		}
		/**
		 *重新开始 
		 * 
		 */		
		public function resetTimer():void
		{
			_timer.reset();
			_timer.start();
		}
		/**
		 *开始定时器 
		 * 
		 */		
		public function start():void
		{
			_timer.start();
		}
		/**
		 *停止定时器 
		 * 
		 */		
		public function stop():void
		{
			_timer.stop();
		}
		/**
		 * Timer
		 * @param e
		 * 
		 */		
		private function onTimer(e:TimerEvent):void
		{
			
			timerCallBack==null?"":timerCallBack();
		}
		/**
		 *complete 
		 * @param e
		 * 
		 */		
		private function onComplete(e:TimerEvent):void
		{
			completeCallBack==null?"":completeCallBack();
		}
		/**
		 *停止定时器 
		 * 
		 */		
		public function clearTimer():void
		{
			if(_timer == null)
			{
				return;
			}
			if(_timer.running)
			{
				_timer.stop();
			}
			_timer.removeEventListener(TimerEvent.TIMER,onTimer);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onComplete);
			_timer = null;
			_timerCallBack = null;
			_completeCallBack = null;
		}
	}
}