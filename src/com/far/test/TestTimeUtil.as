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
		public static function testFun(fun:Function):String
		{
			if (fun == null)
			{
				return "";
			}
			var beginTime:Number=getTimer();
			fun.apply(null);
			var afterTime:Number=getTimer();
			return ((afterTime - beginTime) / 1000).toString();
		}
	}
}
