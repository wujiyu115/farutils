package com.far.utils.displayobject
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;

	public class MouseHandUtil
	{

		/**mc使用手形*/
		public static function useHandCursor(mc:MovieClip):void
		{
			mc.buttonMode=true;
			mc.mouseChildren=false;

		}


		/**密码框 */
		public static function passWordStatue(txt:TextField):void
		{
			txt.displayAsPassword=true;
		}

		/**文本框变手形 */
		public static function TFButtonMode(mytx:TextField):void
		{
			mytx.addEventListener(MouseEvent.MOUSE_OVER, mousesj1);
			mytx.addEventListener(MouseEvent.MOUSE_OUT, mousesj2);

		}

		private static function mousesj1(e:MouseEvent):void
		{

			Mouse.cursor=MouseCursor.HAND;
		}

		private static function mousesj2(e:MouseEvent):void
		{

			Mouse.cursor=MouseCursor.ARROW;
		}
	}
}
