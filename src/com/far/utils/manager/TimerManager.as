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
		private var _timeCount:Array;

		public function TimerManager()
		{
			if (_instance)
				throw new Error("this is a single instance class");
			_timers=new Dictionary(true);
			_timeCount=[];
		}

		static public function get instance():TimerManager
		{
			_instance||=new TimerManager();
			return _instance;
		}

		public function addTimer(name:String, time:int, callBack:Function, repeat:int=1):void
		{
			var timer:Timer=_timers[name];
			if (timer)
				throw new Error("already exist");
			if (_timeCount.indexOf(time) != -1)
				
			timer = new Timer(time,repeat);
			timer.addEventListener(TimerEvent.TIMER,callBackHandler);
			timer.start();
			function callBackHandler(event:TimerEvent):void
			{
				callBack();
			}
		}
		
		
		public function removeTimer(name:String,callBack:Function):void
		{
			var timer:Timer=_timers[name];
			if (timer&&timer.running)
				timer.stop();
		}
	}
}
