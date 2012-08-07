package
{
	import com.far.test.Stats;
	import com.far.utils.manager.InteractiveManager;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;

	[SWF(width="1440", height="900")]
	public class farutils extends Sprite
	{


		public function farutils()
		{
			var s:Stats=new Stats();
			s.x=200;
			addChild(s);
			var imana:InteractiveManager=new InteractiveManager();
			imana.initStage(this);
			for (var i:int=0; i < 1000; i++)
			{
				var sp:ShotSprite=new ShotSprite();
				sp.name="sp" + i;
				addChild(sp);
			}

		}


	}
}
import flash.display.Bitmap;
import flash.display.Sprite;

class ShotSprite extends Sprite
{
	[Embed(source="shot.png")]
	public static var Shot:Class;

	public function ShotSprite():void
	{
		var bitm:Bitmap=new Shot() as Bitmap;
		addChild(bitm);
	}
}

