package com.far.utils.collisions
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;

	/**
	 * @author far
	 * @E-mail: wujiyu115@gmail.com
	 * @version 1.0.0
	 * 创建时间：2012-9-5 上午12:09:05
	 *
	 */
	public class OneObjectMove
	{
		private var _target:DisplayObject;
		private var _objs:Array;

		public function OneObjectMove(target:DisplayObject, objs:Array)
		{
			this._target=target;
			this._objs=objs;
		}

		/**
		 * 
		 * @param one  是否只检测第一个碰到的
		 * @return  
		 * 
		 */		
		public function checkCollisions(one:Boolean=true):Array
		{
			var check:Array=[];
			var len:int=_objs.length;
			for (var i:int=len - 1; i >= 0; i--)
			{
				if (HitTest.complexHitTestObject(_target, _objs[i]))
				{
					check.push(_objs[i]);
					if (one)
						return check;
				}
			}
			return check;

		}
		
	}
}