package com.far.test
{
	import flash.utils.getTimer;

	public class TestTimeUtil
	{
		public function TestTimeUtil()
		{
		}

		public static function testFun(fun:Function):String
		{
			if (fun==null)
			{
				return "";
			}
			var beginTime:Number  = getTimer();
			fun.apply(null);
			var afterTime:Number  = getTimer();
			return ((afterTime-beginTime)/1000).toString();
		}
	}
}
