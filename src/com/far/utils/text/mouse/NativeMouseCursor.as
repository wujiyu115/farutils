package com.far.utils.text.mouse
{
	import flash.display.BitmapData;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;

	/**
	 * 本机鼠标
	 * @author wujiyu
	 *
	 */
	public class NativeMouseCursor
	{
		public function NativeMouseCursor()
		{
		}

		public function registerCursor(data:Vector.<BitmapData>, name:String):void
		{
			var mousedata:MouseCursorData=new MouseCursorData();
			mousedata.data=data;
			if (Mouse.supportsNativeCursor)
				Mouse.registerCursor(name, mousedata);
		}

		public function setCursor(name:String):void
		{
			if (Mouse.supportsNativeCursor)
				Mouse.cursor=name;
		}

		public function unregisterCursor(name:String):void
		{
			if (Mouse.supportsNativeCursor)
				Mouse.unregisterCursor(name);
		}

		public function backCursor():void
		{
			Mouse.cursor=MouseCursor.AUTO;
		}
	}
}
