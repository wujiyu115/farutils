package
{
	import com.far.test.Stats;
	import com.far.utils.manager.InteractiveManager;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.describeType;

	[SWF(width="1440", height="900")]
	public class farutils extends Sprite
	{
		[Embed(source="shot.png")]
		public static var Shot:Class;

		public function farutils()
		{
			var  s:Stats = new Stats();
			s.x = 200;
			addChild(s);
			var imana:InteractiveManager=new InteractiveManager();
			imana.careClasses=[ShotSprite];
			imana.initStage(this);
			for (var i:int=0; i < 100; i++)
			{
				var sp:ShotSprite=new ShotSprite();
				sp.mouseChildren=false;
				sp.name="sp" + i;
				addChild(sp);
			}
			var mc:MovieClip=new MovieClip();
			mc.graphics.beginFill(0xff0000, .5);
			mc.graphics.drawCircle(20, 20, 20);
			mc.graphics.endFill();
			mc.x=50;
			mc.y=50;

			addChild(mc);

		}


	}
}
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;

class ShotSprite extends Sprite
{

	public function ShotSprite():void
	{
		var bitm:Bitmap=new farutils.Shot() as Bitmap;
		addChild(bitm);
	}
}

