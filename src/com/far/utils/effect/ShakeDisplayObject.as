package com.far.utils.effect
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * 震屏效果类
	 * Program Name:  ShakeDisplayObject
	 * @author             wujiyu
	 * @email               wujiyu115@gmail.com
	 * @version            1.0
	 * Time:                  2012-8-22 下午9:17:16
	 */
	public class ShakeDisplayObject
	{
		/**
		 *
		 * @param mc    目标对象
		 * @param rang  震动最大范围
		 * @param rangSpace 递减速幅度
		 *
		 */
		public static function shake(mc:DisplayObject, rang:int=10, rangSpace:int=2):void
		{
			var mx:int=mc.x;
			var my:int=mc.y;
			mc.addEventListener(Event.ENTER_FRAME, shakEnter);
			var dir:int=1;
			function shakEnter(event:Event):void
			{
				dir=-dir;
				mc.x=mx + rang * dir;
				mc.y=my + rang * dir;
				if (dir > 0)
					rang-=rangSpace;
				if (rang == 0)
					mc.removeEventListener(Event.ENTER_FRAME, shakEnter);
			}
		}
	}
}