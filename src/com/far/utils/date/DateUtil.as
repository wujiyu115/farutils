package com.far.utils.date
{
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.DateTimeStyle;

	
	public class DateUtil
	{
		/**
		 *比较两个日期的大小 
		 * @param sourceDate 
		 * @param distDate
		 * @return true(sourceDate >distDate)  false(sourceDate <= sourceDate)
		 * 
		 */		
		public static function compareTwoDate(sourceDate:Date,distDate:Date):Boolean
		{
			if(sourceDate == null || distDate == null)
			{
				throw new Error("Date is Null!");
			}
			var sourceDateTimes :Number = sourceDate.getTime();
			var distDateTimes :Number = distDate.getTime();
			if(sourceDateTimes > distDateTimes)
			{
				return true;
			}else
			{
				return false;
			}
		}
	}
}
