package com.far.utils.displayobject
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	/**
	 *
	 * Program Name:       TimeLineUtil
	 * @author             wujiyu
	 * @email              wujiyu115@gmail.com
	 * @version            1.0
	 * Time:               2012-11-1 下午2:50:38
	 */
	public class TimeLineUtil
	{
		private var _groudName:Dictionary;
		public function TimeLineUtil()
		{
			_groudName= new Dictionary();
		}

		/**
		 * 
		 * @param groupName
		 * @param config
		 * 
		 */		
		public function addTimeLine(groupName:String,config:Array):void
		{
			_groudName [groupName];
		}

		public function startTimeLine(groupName:String):void
		{

		}

		public function hasTimeLine(groupName:String):Boolean
		{

		}
		
		public function addEndEvent(mc:MovieClip,callBack:Function,autoClear:Boolean=true):void{
		       
		}
	}
}