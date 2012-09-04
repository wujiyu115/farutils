package
{
	import com.far.test.JLog;
	import com.far.utils.collisions.OneObjectMove;
	import com.far.utils.displayobject.DrawShape;
	import com.far.utils.displayobject.Pen;

	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="1440", height="900")]
	public class farutils extends Sprite
	{
		var sp:Sprite=DrawShape.createCircle(20, 20, 20);
		var co:OneObjectMove;
		private var speed:Number=3;

		public function farutils()
		{
			addChild(JLog.jLogPanel);
			JLog.author="far";
			JLog.trace("hello,我是", 0xff0000, true, "far");
			JLog.trace("anyone Trace", 0x000000, false);
			JLog.trace("it's a test", 0x000000, true, "far");


			var sp1:Sprite=DrawShape.createCircle(20, 20, 20);
			var sp2:Sprite=DrawShape.createCircle(20, 20, 20);

			sp2.y=sp1.y=sp.y=200;
			sp2.x=200;
			sp1.x=100;

			addChild(sp);
			addChild(sp1);
			addChild(sp2);

			sp1.name="sp1";
			sp2.name="sp2";
			sp.name="sp";

			co=new OneObjectMove(sp, [sp1, sp2]);
			addEventListener(Event.ADDED_TO_STAGE, addTostageHandler);
		}

		protected function addTostageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addTostageHandler);
			addEventListener(Event.ENTER_FRAME, enterHandler);
		}

		protected function enterHandler(event:Event):void
		{
			if (sp.x >= stage.stageWidth||sp.x < 0)
				speed=-speed;
			sp.x+=speed;
			var arr:Array=co.checkCollisions();
			for (var i:int=0; i < arr.length; i++)
			{
				trace(arr[i].name);
			}

		}

	}
}
