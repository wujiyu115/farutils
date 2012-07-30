package com.far.test
{
	import flash.utils.getTimer;

	/**
	 *测试方法执行时间
	 * @author Administrator
	 *
	 */
	public class TestTimeUtil
	{
		public function TestTimeUtil()
		{
		}

		/**
		 *测试方法执行时间
		 * @param fun
		 * @return
		 *
		 */
		public static function testFun(fun:Function,arugs:Array):String
		{
			if (!fun)
				return "";
			var beginTime:Number=getTimer();
			fun.apply(null,arugs);
			var afterTime:Number=getTimer();
			return (afterTime - beginTime).toString();
		}
	}
}
