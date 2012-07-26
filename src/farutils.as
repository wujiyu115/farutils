package
{

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;



	public class farutils extends Sprite
	{
		public function farutils()
		{
			 var txtfield:TextField = new TextField();
			 txtfield.type = TextFieldType.INPUT;
			 txtfield.width=100;
			 txtfield.height = 20;
			 txtfield.border = true;
			 txtfield.borderColor=0;
			 ChineseText(txtfield);
			 addChild(txtfield);
		}

		public static function ChineseText(variable:TextField):void{
			variable.restrict="一-颌";
		
		}
	}
}
