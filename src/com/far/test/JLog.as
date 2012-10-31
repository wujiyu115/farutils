package com.far.test
{

	/**
	 * 测试类
	 *
	 *  addChild(JLog.instance);
	 *	JLog.author="Jason";
	 *	JLog.trace("hello",0xff0000,true,"Jason");
	 *	JLog.trace("anyone",0x000000,false);
	 *  ctrl  隐藏关闭
	 */
	public class JLog extends Object
	{
		private static var _enable:Boolean;
		public static var author:String="";

		public function JLog()
		{
			throw new Error("请使用静态方法");
		}

		public static function set enable(value:Boolean):void
		{
			_enable=value;
			if (instance)
			{
				if (_enable)
				{
					instance.openJLogPanel();
				}
				else
				{
					instance.closeJLogPanel();
				}
			}
			return;
		}

		public static function get enable():Boolean
		{
			return _enable;
		}

		public static function get instance():JLogPanel
		{
			return JLogPanel.instance;
		}

		public static function trace(message:String, authors:String="", color:uint=0x000000):void
		{
			var _loc_4:String="";
			if (author != authors)
			{
				return;
			}
			_loc_4=String(message);
			instance.addMessage(_loc_4, color);
		}

	}
}



import flash.display.*;
import flash.events.*;
import flash.geom.*;
import flash.text.*;
import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;
import flash.utils.*;

class JLogPanel extends Sprite
{
	private var _fps:FPS;
	private var _bg:Shape;
	private var _titleBarBg:Sprite;
	private var _closeSprite:Sprite;
	private var _resize:Sprite;
	private var _message:TextField;
	private var _keyDic:Dictionary;
	private static var _instance:JLogPanel;
	private static const CTRL_KEY:int=74;
	private static const J_KEY:int=17;

	public function JLogPanel()
	{
		this.addEventListener(Event.ADDED_TO_STAGE, addToStage);
	}

	private function addToStage(event:Event):void
	{
		this.visible=false;
		this.removeEventListener(Event.ADDED_TO_STAGE, addToStage);
		this.initView();
		this.initContextMenu();
		this.initListener();
		return;
	}

	private function initListener():void
	{
		this._keyDic=new Dictionary();
		stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
		return;
	}

	private function onKeyDown(event:KeyboardEvent):void
	{
		if (event.keyCode != CTRL_KEY)
		{
			JLog.enable=!JLog.enable;
		}
	}

	private function onKeyUp(event:KeyboardEvent):void
	{
		this._keyDic[event.keyCode]=false;
		return;
	}

	private function initView():void
	{
		this.initBg();
		this.initTitleBar();
		this.initMessage();
		this.initFPS();
		this.initResize();
		this.updateUI();
		return;
	}


	private function initMessage():void
	{
		this._message=new TextField();
		this._message.multiline=true;
		this._message.wordWrap=true;
		this._message.selectable=true;
		this._message.useRichTextClipboard=true;
		this._message.width=this._bg.width;
		this._message.height=this._bg.height - this._titleBarBg.height;
		var _loc_1:TextFormat=new TextFormat();
		_loc_1.font="Tahoma";
		_loc_1.align=TextFormatAlign.LEFT;
		_loc_1.bold=true;
		_loc_1.size=10;
		this._message.defaultTextFormat=_loc_1;
		this._message.text=getTimeStr();
		addChild(this._message);
		return;
	}

	private function getTimeStr():String
	{
		var date:Date=new Date();
		return "[" + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + "]";
	}

	private function initResize():void
	{
		this._resize=new Sprite();
		var _loc_1:*=JConstList.RESIZE_RECT;
		var _loc_2:*=new Shape();
		_loc_2.graphics.beginFill(16777215, 0);
		_loc_2.graphics.drawRect(0, 0, _loc_1, _loc_1);
		_loc_2.graphics.endFill();
		this._resize.addChild(_loc_2);
		with (this._resize)
		{
			graphics.clear();
			graphics.lineStyle(1, 0x000000, 0.8);
			graphics.moveTo(0, _loc_1);
			graphics.lineTo(_loc_1, 0);
			graphics.moveTo(_loc_1 / 3, _loc_1);
			graphics.lineTo(_loc_1, _loc_1 / 3);
			graphics.moveTo(2 * _loc_1 / 3, _loc_1);
			graphics.lineTo(_loc_1, 2 * _loc_1 / 3);
		}
		this._resize.alpha=0.6;
		this.addMouseOverEvent(this._resize);
		this._resize.buttonMode=true;
		this._resize.addEventListener(MouseEvent.MOUSE_DOWN, this.resizeMouseEvent);
		this._resize.addEventListener(MouseEvent.MOUSE_UP, this.resizeMouseEvent);
		addChild(this._resize);
		return;
	}

	private function resizeMouseEvent(event:MouseEvent):void
	{
		switch (event.type)
		{
			case MouseEvent.MOUSE_DOWN:
			{
				stage.addEventListener(MouseEvent.MOUSE_MOVE, this.resizeMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP, this.resizeStageMouseUp);
				break;
			}
			case MouseEvent.MOUSE_UP:
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.resizeMouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP, this.resizeStageMouseUp);
				break;
			}
			default:
			{
				break;
			}
		}
		return;
	}

	private function resizeMouseMove(event:MouseEvent):void
	{
		var _loc_2:int=0;
		var _loc_3:int=0;
		_loc_2=stage.mouseX - x;
		_loc_3=stage.mouseY - y;
		this._bg.width=_loc_2 < JConstList.JPANEL_MIN_WIDTH ? (JConstList.JPANEL_MIN_WIDTH) : (_loc_2);
		this._bg.height=_loc_3 < JConstList.JPANEL_MIN_HEIGHT ? (JConstList.JPANEL_MIN_HEIGHT) : (_loc_3);
		this.resizeUpdate();
		return;
	}

	private function resizeUpdate():void
	{
		this._resize.x=this._bg.width - this._resize.width;
		this._resize.y=this._bg.height - this._resize.height;
		this._titleBarBg.width=this._bg.width;
		this._closeSprite.x=this._titleBarBg.width - this._closeSprite.width - 10;
		this._message.width=this._bg.width;
		this._message.height=this._bg.height;
		return;
	}

	private function resizeStageMouseUp(event:MouseEvent):void
	{
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.resizeMouseMove);
		return;
	}

	private function initTitleBar():void
	{
		this._titleBarBg=new Sprite();
		var _loc_1:*=JConstList.JPANEL_TITLT_BAR_HEIGHT;
		var _loc_2:*=new Matrix();
		_loc_2.createGradientBox(JConstList.JPANEL_DEFAULT_WIDTH, _loc_1, Math.PI / 180 * 90);
		var _loc_3:*=this._titleBarBg.graphics;
		_loc_3.clear();
		_loc_3.beginGradientFill(GradientType.LINEAR, JConstList.TB_COLORS, JConstList.TB_ALPHAS, JConstList.TB_RATIOS, _loc_2);
		_loc_3.drawRoundRectComplex(0, 0, JConstList.JPANEL_DEFAULT_WIDTH, _loc_1, JConstList.CORNER_RADIUS, JConstList.CORNER_RADIUS, 0, 0);
		_loc_3.endFill();
		addChild(this._titleBarBg);
		this._titleBarBg.addEventListener(MouseEvent.MOUSE_DOWN, this.dragMouseEvent);
		this._titleBarBg.addEventListener(MouseEvent.MOUSE_UP, this.dragMouseEvent);
		this._closeSprite=new Sprite();
		this._closeSprite.buttonMode=true;
		this._closeSprite.addEventListener(MouseEvent.MOUSE_DOWN, this.closeSpriteOnClick);
		this._closeSprite.x=this._titleBarBg.width - this._closeSprite.width - 10;
		this._closeSprite.y=JConstList.JPANEL_TITLT_BAR_HEIGHT / 2;
		with (_closeSprite)
		{
			graphics.beginFill(0xffffff, 0.6);
			graphics.drawRoundRect(-8, -8, 16, 16, 5, 5);
			graphics.endFill();
			graphics.lineStyle(1, 0x000000, 1, true);
			graphics.moveTo(Math.cos(Math.PI / 4) * 6, Math.sin(Math.PI / 4) * 6);
			graphics.lineTo(Math.cos(-3 / 4 * Math.PI) * 6, Math.sin(-3 / 4 * Math.PI) * 6);
			graphics.moveTo(Math.cos(-Math.PI / 4) * 6, Math.sin(-Math.PI / 4) * 6);
			graphics.lineTo(Math.cos(3 / 4 * Math.PI) * 6, Math.sin(3 / 4 * Math.PI) * 6);
		}
		this.addMouseOverEvent(this._closeSprite as DisplayObject);
		addChild(this._closeSprite);
		return;
	}


	private function addMouseOverEvent(child:DisplayObject):void
	{
		if (!child)
		{
			return;
		}
		child.addEventListener(MouseEvent.MOUSE_OVER, this.btnMouseOver);
		child.addEventListener(MouseEvent.MOUSE_OUT, this.btnMouseOver);
		return;
	}

	private function btnMouseOver(event:MouseEvent):void
	{
		switch (event.type)
		{
			case MouseEvent.MOUSE_OVER:
			{
				DisplayObject(event.currentTarget).alpha=1;
				break;
			}
			case MouseEvent.MOUSE_OUT:
			{
				DisplayObject(event.currentTarget).alpha=0.6;
				break;
			}
			default:
			{
				break;
			}
		}
		return;
	}

	private function closeSpriteOnClick(event:MouseEvent):void
	{
		JLog.enable=false;
		return;
	}

	private function initBg():void
	{
		this._bg=new Shape();
		this._bg.graphics.clear();
		this._bg.graphics.lineStyle(1, 0xacaeaf, 1);
		this._bg.graphics.beginFill(JConstList.JPANEL_BG_COLOR, JConstList.JPANEL_BG_ALPHA);
		this._bg.graphics.drawRect(0, 0, JConstList.JPANEL_DEFAULT_WIDTH, JConstList.JPANEL_DEFAULT_HEIGHT);
		this._bg.graphics.endFill();
		addChild(this._bg);
		return;
	}

	private function initFPS():void
	{
		this._fps=new FPS();
		addChild(this._fps);
		this._fps.x=0;
		var txt:TextField=new TextField();
		txt.defaultTextFormat=new TextFormat("Tahoma", 10, 13421772);
		txt.text="Ctrl隐藏";
		txt.x=130;
		addChild(txt);
		return;
	}

	private function dragMouseEvent(event:MouseEvent):void
	{
		switch (event.type)
		{
			case MouseEvent.MOUSE_DOWN:
			{
				_instance.startDrag();
				stage.addEventListener(MouseEvent.MOUSE_UP, this.stageOnMouseUp);
				break;
			}
			case MouseEvent.MOUSE_UP:
			{
				_instance.stopDrag();
				stage.removeEventListener(MouseEvent.MOUSE_UP, this.stageOnMouseUp);
				break;
			}
			default:
			{
				break;
			}
		}
		return;
	}

	private function stageOnMouseUp(event:MouseEvent):void
	{
		trace("stageMouseUp");
		_instance.stopDrag();
		return;
	}

	public function addMessage(str:String, color:uint=0x000000):void
	{
		var message:String="<p><font color=\'#" + color.toString(16) + "\'>" + str + "</p>";
		this._message.htmlText=this._message.htmlText + message;
		return;
	}

	public function updateUI():void
	{
		this.x=Math.abs((this.stage.stageWidth - this.width) / 2);
		this.y=Math.abs((this.stage.stageHeight - this.height) / 2);
		if (this._resize)
		{
		}
		if (this._resize.parent)
		{
			this._resize.x=this.width - this._resize.width;
			this._resize.y=this.height - this._resize.height;
		}
		if (this._message)
		{
		}
		if (this._message.parent)
		{
			this._message.y=this._titleBarBg.y + this._titleBarBg.height;
		}
		return;
	}

	public function closeJLogPanel():void
	{
		this.visible=false;
		return;
	}

	public function openJLogPanel():void
	{
		this.visible=true;
		return;
	}

	public function disposeview():void
	{
		return;
	}

	public static function get instance():JLogPanel
	{
		if (_instance == null)
		{
			_instance=new JLogPanel;
		}
		return _instance;
	}

	private function initContextMenu():void
	{
		var myContextMenu:ContextMenu=new ContextMenu();
		var item:ContextMenuItem=new ContextMenuItem("清除内容");
		myContextMenu.customItems.push(item);
		item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuSelectHandler);
		this.contextMenu=myContextMenu;
	}

	private function menuSelectHandler(event:ContextMenuEvent):void
	{
		this._message.text="";
	}

}

class JConstList extends Object
{
	public static const JPANEL_BG_COLOR:uint=0xeeebeb; //背景色
	public static const JPANEL_BG_ALPHA:Number=1;
	public static const JPANEL_DEFAULT_WIDTH:int=200; //宽
	public static const JPANEL_DEFAULT_HEIGHT:int=175; //高
	public static const JPANEL_TITLT_BAR_HEIGHT:int=25; //标题高
	public static const TB_COLORS:Array=[5855577, 2500134, 1644825, 460551];
	public static const TB_ALPHAS:Array=[1, 1, 1, 1];
	public static const TB_RATIOS:Array=[0, 128, 129, 255];
	public static const CORNER_RADIUS:int=5;
	public static const BUTTON_BG_RADIUS:int=8;
	public static const RESIZE_RECT:int=15;
	public static const JPANEL_MIN_WIDTH:int=200;
	public static const JPANEL_MIN_HEIGHT:int=175;
	public static const JLOG_TRACE_COLOR_RED:uint=16711680;
	public static const JLOG_TRACE_COLOR_BLUE:uint=102;
	public static const JLOG_TRACE_COLOR_WHITE:uint=16777215;

	public function JConstList()
	{
	}

}

import flash.display.*;
import flash.events.*;
import flash.system.*;
import flash.text.*;
import flash.utils.*;

class FPS extends Sprite
{
	private var fpsTxt:TextField;
	private var memTxt:TextField;
	private var fps_width:Number;
	private var fps_height:Number;
	private var fps_bg:Sprite;
	private var fps_bitmapData:BitmapData;
	private var fps_bitmapHeight:int;
	private var time:int;
	private var frameCount:int=0;

	public function FPS()
	{
		addEventListener(Event.ADDED_TO_STAGE, this.init);
		return;
	}

	private function init(event:Event):void
	{
		this.fps_width=180;
		this.fps_height=10;
		removeEventListener(Event.ADDED_TO_STAGE, this.init);
		mouseEnabled=false;
		mouseChildren=false;
		this.fpsTxt=new TextField();
		this.fpsTxt.defaultTextFormat=new TextFormat("Tahoma", 10, 13421772);
		this.fpsTxt.autoSize=TextFieldAutoSize.LEFT;
		this.fpsTxt.text="FPS: " + Number(stage.frameRate).toFixed(2);
		this.fpsTxt.selectable=false;
		addChild(this.fpsTxt);
		this.memTxt=new TextField();
		this.memTxt.defaultTextFormat=new TextFormat("Tahoma", 10, 13421568);
		this.memTxt.autoSize=TextFieldAutoSize.LEFT;
		this.memTxt.text="Memery: " + this.getMemeryToString(System.totalMemory);
		this.memTxt.x=this.fpsTxt.width;
		this.memTxt.y=this.fpsTxt.y;
		addChild(this.memTxt);
		//            this.fps_bg = new Sprite();
		//            this.fps_bg.graphics.lineStyle();
		//            this.fps_bg.graphics.beginFill(1342177280, 0.7);
		//            this.fps_bg.graphics.drawRect(0, 0, this.fps_width, this.memTxt.height + this.fpsTxt.height);
		//            this.fps_bg.graphics.endFill();
		//            addChildAt(this.fps_bg, 0);
		//            this.fps_bitmapData = new BitmapData(this.fps_width, this.fps_height, true, 1342177280);
		//            var _loc_2:* = new Bitmap(this.fps_bitmapData);
		//            _loc_2.y = this.memTxt.height + this.fpsTxt.height;
		this.time=getTimer();
		this.stage.addEventListener(Event.ENTER_FRAME, this.onEnter);
		return;
	}

	private function onEnter(event:Event):void
	{
		var _loc_2:*=getTimer() - this.time;
		if (_loc_2 >= 1000)
		{
			this.fpsTxt.text="FPS: " + Number(1000 * this.frameCount / _loc_2).toFixed(2);
			this.memTxt.text="Memery: " + this.getMemeryToString(System.totalMemory);
			this.frameCount=0;
			this.time=getTimer();
		}
		var _loc_3:*=this;
		var _loc_4:*=this.frameCount + 1;
		_loc_3.frameCount=_loc_4;
		return;
	}

	private function getMemeryToString(memory:uint):String
	{
		var _loc_2:String=null;
		if (memory < 1024)
		{
			_loc_2="" + memory + "b";
		}
		else if (memory < 10240)
		{
			_loc_2="" + (memory / 1024).toFixed(2) + "kb";
		}
		else if (memory < 102400)
		{
			_loc_2="" + (memory / 1024).toFixed(1) + "kb";
		}
		else if (memory < 1048576)
		{
			_loc_2="" + memory / 1024 + "kb";
		}
		else if (memory < 10485760)
		{
			_loc_2="" + (memory / 1048576).toFixed(2) + "mb";
		}
		else if (memory < 104857600)
		{
			_loc_2="" + (memory / 1048576).toFixed(1) + "mb";
		}
		else
		{
			_loc_2="" + Math.round(memory / 1048576) + "mb";
		}
		return _loc_2;
	}

}
