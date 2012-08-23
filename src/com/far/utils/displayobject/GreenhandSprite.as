package com.far.compoments
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * 新手引导
	 * */
	public class GreenHandSprite extends Sprite
	{
		public function GreenhandSprite()
		{
			super();
		}

		public function drawHollow(size:Rectangle, hollow:Rectangle, color:uint=0, alpha:Number=.5):void
		{
			var grp:Graphics=this.graphics;
			grp.beginFill(color, alpha);
			grp.drawRect(size.x, size.y, size.width, size.height);
			grp.drawRect(hollow.x, hollow.y, hollow.width, hollow.height);
			grp.endFill();
		}
	}
}
