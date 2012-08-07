package   com.far.utils.manager
{    
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class MyTimer 
	{
		private static var _instance:MyTimer;        
		private var _timer:Timer;
		private var _timerList:Array;
		
		/*
		* 获取单例类MyTimer的实例 
		* 返回值：
		*         _instance
		*/        
		public static function getInstance():MyTimer 
		{
			if (_instance == null)
				_instance = new MyTimer();
			
			return _instance;
		}
		
		/*
		* 构造函数，用于防止单例类生成多个实例
		*/
		public function MyTimer() 
		{
			if (_instance != null)
				trace("单例类，请不要实例化");
			return;
		}
		
		/*
		* 注册计时器，首先检查id是否存在，如果不存在，就将定时器插入数组_timerList中；否则啥都不做
		* 参数：
		*         id - 唯一标识一个定时器
		*         interval - 刷新间隔，单位为秒（s）
		*         repeatCount - 重复次数
		*         callback - 回调函数，每隔interval就执行一次
		*         ...args - 回调函数参数 ///注意，参数实际并没有用到，有待改进
		* 返回值：空
		*/
		public function registerTimer(id:String, interval:int, repeatCount:int, callback:Function, ...args):void
		{
			if (_timerList == null)
				_timerList = new Array();
			
			if ( check(id) == -1 )
			{
				_timerList.push( { id:id, interval:interval, repeatCount:repeatCount, callback:callback, args:args, tempInterval:0 } );
				startTimer();
			}
			else
			{
				trace(id + "已经存在！！！");
			}
		}
		
		/*
		* 注销计时器，首先检查id是否存在，如果存在，从数组_timerList中删除定时器
		* 参数：
		*         id - 唯一标识一个定时器
		* 返回值：空
		*/
		public function removeTimer(id:String):void
		{
			var index:int = check(id);
			if (index != -1)
			{
				_timerList.splice(index, 1);    
			}
		}
		
		/*
		* 检查指定id的Object是否在_timerList数组中，
		* 如果存在返回在_timerList数组中的索引；否则返回-1
		* 参数：
		*         id - String，唯一标识一个定时器 
		* 返回值：
		*         -1 or 指定Object的索引
		*/
		private function check(id:String):int
		{
			var len:int = _timerList.length;            
			
			for (var index:int = 0; index < len; index++)
			{
				if (_timerList[index]["id"] == id)
				{
					return index;
				}
			}            
			
			return -1;
		}
		
		/*
		* 启动计时器
		* 如果_timer为空，生成一个定时器Timer，事件发生间隔1000ms（1s）；
		* 监听TimerEvent.TIMER，处理函数为timerHandler
		*/        
		private function startTimer():void
		{
			if (_timer == null)
				_timer = new Timer(1000);
			if (!_timer.running)
			{
				_timer.addEventListener(TimerEvent.TIMER, timerHandler);
				_timer.start();
			}
		}
		
		/*
		* 停止计时器
		* 当_timerList数组为空时，即没有用户注册定时器，停止_timer
		*/
		private function stopTimer():void 
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
		}
		
		/*
		* 运行计时器
		* 如果_timerList数组为空，调用stopTimer()停止计时器；
		* 否则判断_timerList数组中的定时器间隔是否达到，
		*         如果达到，就调用回调函数；
		*         否则啥都不做
		*/        
		public function runTimer():void
		{
			var timerComplete:Array = new Array();
			var len:int = _timerList.length;            
			if (len == 0)
			{
				stopTimer();
				return;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				//运行MyTimer管理的所有计时器
				
				_timerList[i]["tempInterval"] += 1;
				//判断是否已经经过interval间隔
				if (_timerList[i]["tempInterval"] == _timerList[i]["interval"])
				{
					//如果callback不空，执行callback函数
					if (_timerList[i]["callback"] != null)
					{
						_timerList[i]["callback"](_timerList[i]["args"]);
					}
					
					_timerList[i]["tempInterval"] = 0;
					
					//判断初始repeatCount是否=0，如果注册时为0，即无限次数
					//否则每执行一次，就-1；然后判断repeatCount是否=0，如果=0就注销计时器
					if (_timerList[i]["repeatCount"] != 0)
					{
						_timerList[i]["repeatCount"] -= 1;
						if (_timerList[i]["repeatCount"] == 0)
						{
							trace("执行完成......");
							timerComplete.push(_timerList[i]["id"]);
						}
					}
				}
			}
			
			//注销所有已完成的计时器
			len = timerComplete.length;
			if (len != 0)
			{
				trace("注销所有已经完成的计时器...");
				for ( i = 0; i < len; i++)
				{
					removeTimer(timerComplete.pop());
				}
			}
		}
		
		/*
		* timerHandler是_timer的TimerEvent.TIMER事件处理函数
		* 其中调用runTimer()，管理所有注册的计时器
		*/
		private function timerHandler(evt:TimerEvent):void
		{
			runTimer();
		}
	}
}