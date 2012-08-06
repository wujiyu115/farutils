package
{
	import com.far.utils.manager.InteractiveManager;

	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	[SWF(width="1440", height="900")]
	public class farutils extends Sprite
	{
		[Embed(source="shot.png")]
		public static var Shot:Class;

		public function farutils()
		{
			this.addEventListener(MouseEvent.CLICK, clickHandler);
			var imana:InteractiveManager=new InteractiveManager();
			imana.careClasses=[ShotSprite];
			imana.initStage(this);
			for (var i:int=0; i < 2; i++)
			{
				var sp:ShotSprite=new ShotSprite();
				sp.name="sp" + i;
				sp.x=i * 60;
				addChild(sp);
			}
			var sp1:ShotSprite=new ShotSprite();
			sp1.name="sp2";
			sp1.x=0;
			sp1.y=20;
			addChild(sp1);

			var mc:MovieClip=new MovieClip();
			mc.graphics.beginFill(0xff0000, .5);
			mc.graphics.drawCircle(20, 20, 20);
			mc.graphics.endFill();
			mc.x=50;
			mc.y=50;

			addChild(new ShotOne());
			//addChild(mc);
		}

		protected function clickHandler(event:MouseEvent):void
		{
			trace(event.target.name);
		}

	}
}
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;

class ShotSprite extends Sprite
{

	public function ShotSprite():void
	{
		var bitm:Bitmap=new farutils.Shot() as Bitmap;
		addChild(bitm);
	}
}

class ShotOne extends MovieClip
{
	public function ShotOne()
	{

		var mc:MovieClip=new MovieClip();
		mc.graphics.beginFill(0xff0000, .5);
		mc.graphics.drawCircle(20, 20, 20);
		mc.graphics.endFill();
		mc.x=50;
		mc.y=50;
		var mc1:MovieClip=new MovieClip();
		mc1.graphics.beginFill(0xff0000, 1);
		mc1.graphics.drawCircle(10, 10, 10);
		mc1.graphics.endFill();
		mc1.x=10;
		mc1.y=10;
		mc.addChild(mc1);
		addChild(mc);
	}
}
