package  com.far.utils.interactive.mouse {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.ui.Mouse;
	import flash.utils.getDefinitionByName;
	
	/**
	 * 自定义鼠标
	 * http://code.google.com/p/lostinactionscript/source/browse/trunk/library/com/lia/utils/CustomMouseCursor.as
	 */
	public class CustomMouseCursor {
		
		public static var COLOUR_PICKER : String = "ColorPickerMouseCursor";
		
		private static var stageReference : Stage;
		public static var currentCursor : Sprite;
		private static const cursorDropShadowFilter : DropShadowFilter = new DropShadowFilter(1, 45, 0x000000, 0.5);
		
		public static function init(stage : Stage) : void {
			stageReference = stage;
		}
		/**
		 *根据自定义鼠标类名得到鼠标类 
		 * @param cursorType
		 * 
		 */		
		public static function show(cursorType : String) : void {
			removeCurrent();
			
			var CustomCursor : Class = getDefinitionByName(cursorType) as Class;
			
			currentCursor = new CustomCursor();
			
			currentCursor.filters = [cursorDropShadowFilter];
			currentCursor.mouseEnabled = currentCursor.mouseChildren = false;
			currentCursor.x = stageReference.mouseX;
			currentCursor.y = stageReference.mouseY;
			
			stageReference.addChild(currentCursor);
			
			stageReference.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			Mouse.hide();
		}
		
		public static function hide() : void {
			removeCurrent();
			Mouse.show();
		}
		
		private static function removeCurrent() : void {
			if(currentCursor) {
				stageReference.removeChild(currentCursor);
				currentCursor = null;
				
				stageReference.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
		}
		
		private static function onMouseMove(event : MouseEvent) : void {
			currentCursor.x = stageReference.mouseX;
			currentCursor.y = stageReference.mouseY;
		}
	}
}