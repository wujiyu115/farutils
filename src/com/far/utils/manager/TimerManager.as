package com.far.utils.manager
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	/**
	 *timer管理
	 * @author Administrator
	 *
	 */
	public class TimerManager
	{
		private static var _instance:TimerManager;
		private var _timers:Dictionary;
		private var _callbacks:Dictionary;
		private var _repeats:Dictionary;

		public function TimerManager()
		{
			if (_instance)
				throw new Error("this is a single instance class");
			_timers=new Dictionary(true);
			_callbacks=new Dictionary(true);
			_repeats=new Dictionary(true);
		}

		static public function get instance():TimerManager
		{
			_instance||=new TimerManager();
			return _instance;
		}

		/**
		 * 
		 * @param time 时间
		 * @param callBack  回调  返回计数
		 * @param repeat    需要调用多少次
		 * 
		 */		
		public function addTimer(time:int, callBack:Function, repeat:int=-1):void
		{
			var timer:Timer=_timers[time];
			if (!timer)
			{
				_callbacks[time]=[callBack];
				_repeats[callBack]=repeat;
				timer=new Timer(time, 0);
				timer.addEventListener(TimerEvent.TIMER, callBackHandler);
				_timers[time]=timer;
				timer.start();
			}
			else
			{
				var callbacks:Array=_callbacks[time];
				if (callbacks.indexOf(callBack) != -1)
					throw new Error("already added");
				callbacks.push(callBack);
				_repeats[callBack]=repeat;
			}

		}

		protected function callBackHandler(event:TimerEvent):void
		{
			var delay:int=(event.target as Timer).delay;
			var arr:Array=_callbacks[delay];
			var i:int=arr.length;
			while (i--)
			{
				var callback:Function=arr[i] as Function;
				var repeat:int=_repeats[callback];
				if (repeat)
				{
					callback.apply(null, [repeat]);
					if (repeat != -1)
					{
						repeat--;
						if (repeat)
						{
							_repeats[callback]=repeat;
						}
						else
						{
							arr.splice(i, 1);
							callback=null;
							if (arr.length == 0)
							{
								var tim:Timer=(event.target as Timer)
								tim.stop();
								tim.removeEventListener(TimerEvent.TIMER, callBackHandler);
								tim=null;
								_timers[delay]=null;
							}
						}
					}
				}
			}

		}

		public function removeTimer(time:int, callBack:Function):void
		{
			var arr:Array=_callbacks[time];
			var index:int=arr.indexOf(callBack);
			if (index != -1)
			{
				arr.splice(index, 1);
				if (arr.length == 0)
				{
					var tim:Timer=_timers[time];
					tim.stop();
					tim.removeEventListener(TimerEvent.TIMER, callBackHandler);
					tim=null;
					_timers[time]=null;
				}
			}
		}

		public function clear():void
		{
			for each (var timer:Timer in _timers)
			{
				if (timer.running)
					timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, callBackHandler);
				timer=null;
			}
			_timers=new Dictionary(true);
			_callbacks=new Dictionary(true);
			_repeats=new Dictionary(true);
		}
	}
}

