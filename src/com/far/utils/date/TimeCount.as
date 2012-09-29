package com.far.utils.date 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**时钟类 获取时分秒*/
	public class TimeCount
	{
		private var timer:Timer;
		private var  fun:Function;
		private var date:Date;
	

		public function TimeCount(defaultTime:Number,fun:Function)
		{
			this.fun = fun;
			date= new Date();
			date.setTime(defaultTime);
			timer=new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			date.setTime(date.getTime()+1000);
			fun.apply(null,[formatTime(date)]);
		}
		
		public static function formatTime(d:Date):String
		{
			
			var hours:Number = d.getHours();
			var minutes:Number = d.getMinutes();
			var seconds:Number = d.getSeconds();
			
			var sb:String = new String();
			if (hours < 10)
			{
				sb += "0";
			}
			sb += hours;
			sb += ":";
			if (minutes < 10)
			{
				sb += "0";
			}
			sb += minutes;
			sb += ":";
			if (seconds < 10)
			{
				sb += "0";
			}
			sb += seconds;
			
			return sb;
		}
		public function clear():void{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			timer=null;
			date= null;
		}
	}
}
