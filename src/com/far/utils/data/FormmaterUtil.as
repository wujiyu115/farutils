package com.far.utils.data
{
	import flash.globalization.CurrencyFormatter;
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.NumberFormatter;

	/**格式化工具类  Flash Player 10.1, AIR 2*/
	public class FormmaterUtil
	{
		private static var localeId:String="zh_CN";
		private static var dateformatter:DateTimeFormatter=new DateTimeFormatter(localeId);
		private static var numberformatter:NumberFormatter=new NumberFormatter(localeId);
		private static var currencyformatter:CurrencyFormatter=new CurrencyFormatter(localeId);


		/**设置语言*/
		public static function setLocaleID(localeIdStr:String="zh_CN"):void
		{
			if (localeIdStr != localeId)
			{
				dateformatter=new DateTimeFormatter(localeIdStr);
			}
		}


		/**自定义格式化日期
		 * @example FormmaterUtil.formatterDate(new Date(),"yyyy-MM-dd EEEE")
		 * */
		public static function formatterDate(date:Date, pattern:String):String
		{
			dateformatter.setDateTimePattern(pattern);
			return dateformatter.format(date);
		}

		/**自定义格式化RMB
		 * @example
		 * */
		public static function formatterMoneyRMB(number:int, trailingNumber:int=2):String
		{
			currencyformatter.fractionalDigits=trailingNumber;
			currencyformatter.setCurrency("CNY", "￥");
			return currencyformatter.format(number, true);
		}

		/**自定义格式化 美元
		 * @example
		 * */
		public static function formatterMoneyUSD(number:int, trailingNumber:int=2):String
		{
			currencyformatter.fractionalDigits=trailingNumber;
			currencyformatter.setCurrency("USD", "$");
			return currencyformatter.format(number, true);
		}

		/** 格式化筹码按钮金钱   1k1w1E */
		public static function formarChipBtnMoney(money:String):String
		{
			if (money == null)
			{
				return "";
			}
			var resultStr:String="";
			var len:int=money.length;
			if (len < 5)
			{
				if (len == 4)
				{
					resultStr=(Number(money) / 1000) + "K";
				}
				else
				{
					resultStr=money;
				}
			}
			else if (len <= 8)
			{ //<=千万
				resultStr=(Number(money) / 10000) + "W";
			}
			else
			{ //亿
				resultStr=(Number(money) / 100000000) + "E";
			}
			return resultStr;
		}
	}
}
