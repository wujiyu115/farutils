package app.activity.weekendbubble.util
{

	/**
	 *
	 * Program Name:       TimeJudgeUtil
	 * @author             wujiyu
	 * @email              wujiyu115@gmail.com
	 * @version            1.0
	 * Time:               2012-9-27 下午4:55:26
	 */
	public class TimeJudgeUtil
	{

		public static const beginHour:int=14;
		public static const endHour:int=15;

		/**
		 *是否在活动时间
		 * @param now
		 * @param hourOne
		 * @param hourTwo
		 * @return
		 *
		 */
		public static function isActivityTime(serverTime:Number):Boolean
		{
			var date:Date=new Date(serverTime);
			var hour:int=date.getHours();
			return (hour >= beginHour && hour < endHour);
		}
		
		/**
		 *是否越过活动时间
		 * @param now
		 * @param hourOne
		 * @param hourTwo
		 * @return
		 *
		 */
		public static function outActivityTime(serverTime:Number):Boolean
		{
			var date:Date=new Date(serverTime);
			var hour:int=date.getHours();
			return (hour>= endHour);
		}


		/**
		 *活动时间差
		 * @param serverTime
		 * @param beginTime
		 * @return
		 *
		 */
		public static function getRemainTime(serverTime:Number):Number
		{
			var date:Date=new Date(serverTime);
			date.setHours(beginHour, 0, 0, 0);
			var differ:Number=date.time - serverTime;
			differ=differ > 0 ? differ : differ + 86400000;
			return differ;
		}

		/**
		 *格式化时间差
		 * @param differ
		 * @return
		 *
		 */
		public static function formatDifferTime(differ:Number):String
		{
			var day:int=int(differ / (86400000));
			var hour:int=int(differ / (3600000)) - (day * 24);
			var minute:int = int(differ / (60000)) - (day * 1440) - (hour * 60);   
			var second:int = int(differ / (1000)) - (day * 86400) - (hour * 3600) - (minute*60);  

			var sb:String="";
			sb=hour < 10 ? "0" + hour + "小时" : hour + "小时";
			sb+=minute < 10 ? "0" + minute+"分"  : minute+"分";
			sb+=second < 10 ? "0" + second : second;
			return sb;
		}

		/**
		 *服务器时间与本机时间差多少秒
		 * @param now
		 * @param serverTime
		 * @return
		 *
		 */
		public static function getRemainSecond(serverTime:Number):int
		{
			var differ:Number=new Date().time - serverTime;
			var day:int=int(differ / (86400000));
			var hour:int=int(differ / (3600000)) - (day * 24);
			var minute:int=int(differ / (60000)) - (day * 1440) - (hour * 60);
			var second:int=int(differ / (1000)) - (day * 86400) - (hour * 3600) - (minute * 60);
			return second;
		}

	
}