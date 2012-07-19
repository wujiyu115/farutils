package com.far.utils.motion
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class TweenLite extends Object
    {
        public var delay:Number;
        protected var _hasUpdate:Boolean;
        protected var _subTweens:Array;
        protected var _initted:Boolean;
        public var startTime:int;
        public var target:Object;
        public var duration:Number;
        protected var _hst:Boolean;
        protected var _isDisplayObject:Boolean;
        protected var _active:Boolean;
        public var tweens:Array;
        public var vars:Object;
        public var initTime:int;
        private static var _timer:Timer = new Timer(2000);
        private static var _classInitted:Boolean;
        public static var isStop:Boolean;
        public static var defaultEase:Function = TweenLite.easeOut;
        public static var version:Number = 8.01;
		private  static var _all:Dictionary = new Dictionary();
        private static var _sprite:Sprite = new Sprite();
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
		private   static var _curTime:uint;
        public static var overwriteManager:Object;
        private static var _listening:Boolean;

        public function TweenLite(param1:Object, param2:Number, param3:Object)
        {
            var _loc_5:* = undefined;
            if (param1 == null)
            {
                return;
            }
            if (!_classInitted)
            {
                _curTime = getTimer();
                _sprite.addEventListener(Event.ENTER_FRAME, executeAll);
                if (overwriteManager == null)
                {
                    overwriteManager = {mode:1, enabled:false};
                }
                _classInitted = true;
            }
            var _loc_4:* = param3.overwrite == undefined ? (overwriteManager.mode) : (int(param3.overwrite));
            if (_all[param1] == undefined || param1 != null && _loc_4 == 1)
            {
                delete _all[param1];
                _all[param1] = new Dictionary(true);
            }
            _all[param1][this] = this;
            this.vars = param3;
            this.duration = param2 || 0.001;
            this.delay = param3.delay || 0;
            _active = param2 == 0 && this.delay == 0;
            this.target = param1;
            _isDisplayObject = param1 is DisplayObject;
            if (!(this.vars.ease is Function))
            {
                this.vars.ease = defaultEase;
            }
            if (this.vars.easeParams != null)
            {
                this.vars.proxiedEase = this.vars.ease;
                this.vars.ease = easeProxy;
            }
            if (!isNaN(Number(this.vars.autoAlpha)))
            {
                this.vars.alpha = Number(this.vars.autoAlpha);
                this.vars.visible = this.vars.alpha > 0;
            }
            this.tweens = [];
            _subTweens = [];
            var _loc_6:Boolean = false;
            _initted = false;
            _hst = _loc_6;
            this.initTime = _curTime;
            if (this.vars.runBackwards == true && this.vars.renderOnStart != true || _active)
            {
                initTweenVals();
                this.startTime = _curTime;
                if (_active)
                {
                    render((this.startTime + 1));
                }
                else
                {
                    render(this.startTime);
                }
                _loc_5 = this.vars.visible;
                if (this.vars.isTV == true)
                {
                    _loc_5 = this.vars.exposedProps.visible;
                }
                if (_loc_5 != null && this.vars.runBackwards == true && _isDisplayObject)
                {
                    this.target.visible = Boolean(_loc_5);
                }
            }
            if (!_listening && !_active)
            {
                _timer.addEventListener("timer", killGarbage);
                _timer.start();
                _listening = true;
            }
            return;
        }// end function

        protected function addSubTween(param1:String, param2:Function, param3:Object, param4:Object, param5:Object = null) : void
        {
            var _loc_7:String = null;
            var _loc_6:Object = {name:param1, proxy:param2, target:param3, info:param5};
            _subTweens[_subTweens.length] = _loc_6;
            for (_loc_7 in param4)
            {
                
                if (typeof(param4[_loc_7]) == "number")
                {
                    this.tweens[this.tweens.length] = {o:param3, p:_loc_7, s:param3[_loc_7], c:param4[_loc_7] - param3[_loc_7], sub:_loc_6, name:param1};
                    continue;
                }
                this.tweens[this.tweens.length] = {o:param3, p:_loc_7, s:param3[_loc_7], c:Number(param4[_loc_7]), sub:_loc_6, name:param1};
            }
            _hst = true;
            return;
        }// end function

        public function initTweenVals(param1:Boolean = false, param2:String = "") : void
        {
            var _loc_3:String = null;
            var _loc_4:int = 0;
            var _loc_6:Array = null;
            var _loc_7:ColorTransform = null;
            var _loc_8:ColorTransform = null;
            var _loc_9:Object = null;
            var _loc_5:* = this.vars;
            if (this.vars.isTV == true)
            {
                _loc_5 = _loc_5.exposedProps;
            }
            if (!param1 && overwriteManager.enabled)
            {
                overwriteManager.manageOverwrites(_loc_5, _all[this.target]);
            }
            if (this.target is Array)
            {
                _loc_6 = this.vars.endArray || [];
                _loc_4 = 0;
                while (_loc_4 < _loc_6.length)
                {
                    
                    if (this.target[_loc_4] != _loc_6[_loc_4] && this.target[_loc_4] != undefined)
                    {
                        this.tweens[this.tweens.length] = {o:this.target, p:_loc_4.toString(), s:this.target[_loc_4], c:_loc_6[_loc_4] - this.target[_loc_4], name:_loc_4.toString()};
                    }
                    _loc_4++;
                }
            }
            else
            {
                if ((typeof(_loc_5.tint) != "undefined" || this.vars.removeTint == true) && _isDisplayObject)
                {
                    _loc_7 = this.target.transform.colorTransform;
                    _loc_8 = new ColorTransform();
                    if (_loc_5.alpha != undefined)
                    {
                        _loc_8.alphaMultiplier = _loc_5.alpha;
                        delete _loc_5.alpha;
                    }
                    else
                    {
                        _loc_8.alphaMultiplier = this.target.alpha;
                    }
                    if (this.vars.removeTint != true && (_loc_5.tint != null && _loc_5.tint != "" || _loc_5.tint == 0))
                    {
                        _loc_8.color = _loc_5.tint;
                    }
                    addSubTween("tint", tintProxy, {progress:0}, {progress:1}, {target:this.target, color:_loc_7, endColor:_loc_8});
                }
                if (_loc_5.frame != null && _isDisplayObject)
                {
                    addSubTween("frame", frameProxy, {frame:this.target.currentFrame}, {frame:_loc_5.frame}, {target:this.target});
                }
                if (!isNaN(this.vars.volume) && this.target.hasOwnProperty("soundTransform"))
                {
                    addSubTween("volume", volumeProxy, this.target.soundTransform, {volume:this.vars.volume}, {target:this.target});
                }
                for (_loc_3 in _loc_5)
                {
                    
                    if (_loc_3 == "ease" || _loc_3 == "delay" || _loc_3 == "overwrite" || _loc_3 == "onComplete" || _loc_3 == "onCompleteParams" || _loc_3 == "runBackwards" || _loc_3 == "visible" || _loc_3 == "autoOverwrite" || _loc_3 == "persist" || _loc_3 == "onUpdate" || _loc_3 == "onUpdateParams" || _loc_3 == "autoAlpha" || _loc_3 == "onStart" || _loc_3 == "onStartParams" || _loc_3 == "renderOnStart" || _loc_3 == "proxiedEase" || _loc_3 == "easeParams" || param1 && param2.indexOf(" " + _loc_3 + " ") != -1)
                    {
                        continue;
                    }
                    if (!(_isDisplayObject && (_loc_3 == "tint" || _loc_3 == "removeTint" || _loc_3 == "frame")) && !(_loc_3 == "volume" && this.target.hasOwnProperty("soundTransform")))
                    {
                        if (typeof(_loc_5[_loc_3]) == "number")
                        {
                            this.tweens[this.tweens.length] = {o:this.target, p:_loc_3, s:this.target[_loc_3], c:_loc_5[_loc_3] - this.target[_loc_3], name:_loc_3};
                            continue;
                        }
                        this.tweens[this.tweens.length] = {o:this.target, p:_loc_3, s:this.target[_loc_3], c:Number(_loc_5[_loc_3]), name:_loc_3};
                    }
                }
            }
            if (this.vars.runBackwards == true)
            {
                _loc_4 = this.tweens.length - 1;
                while (_loc_4 > -1)
                {
                    
                    _loc_9 = this.tweens[_loc_4];
                    this.tweens[_loc_4].s = _loc_9.s + _loc_9.c;
                    _loc_9.c = _loc_9.c * -1;
                    _loc_4 = _loc_4 - 1;
                }
            }
            if (_loc_5.visible == true && _isDisplayObject)
            {
                this.target.visible = true;
            }
            if (this.vars.onUpdate != null)
            {
                _hasUpdate = true;
            }
            _initted = true;
            return;
        }// end function

        public function get active() : Boolean
        {
            if (_active)
            {
                return true;
            }
            if ((_curTime - this.initTime) / 1000 > this.delay)
            {
                _active = true;
                this.startTime = this.initTime + this.delay * 1000;
                if (!_initted)
                {
                    initTweenVals();
                }
                else if (this.vars.visible != undefined && _isDisplayObject)
                {
                    this.target.visible = true;
                }
                if (this.vars.onStart != null)
                {
                    this.vars.onStart.apply(null, this.vars.onStartParams);
                }
                if (this.duration == 0.001)
                {
                    (this.startTime - 1);
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function render(param1:uint) : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_2:* = (param1 - this.startTime) / 1000;
            if (_loc_2 >= this.duration)
            {
                _loc_2 = this.duration;
                _loc_3 = 1;
            }
            else
            {
                _loc_3 = this.vars.ease(_loc_2, 0, 1, this.duration);
            }
            _loc_5 = this.tweens.length - 1;
            while (_loc_5 > -1)
            {
                
                _loc_4 = this.tweens[_loc_5];
                _loc_4.o[_loc_4.p] = _loc_4.s + _loc_3 * _loc_4.c;
                _loc_5 = _loc_5 - 1;
            }
            if (_hst)
            {
                _loc_5 = _subTweens.length - 1;
                while (_loc_5 > -1)
                {
                    
                    _subTweens[_loc_5].proxy(_subTweens[_loc_5]);
                    _loc_5 = _loc_5 - 1;
                }
            }
            if (_hasUpdate)
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            }
            if (_loc_2 == this.duration)
            {
                complete(true);
            }
            return;
        }// end function

        protected function easeProxy(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams));
        }// end function

        public function killVars(param1:Object) : void
        {
            if (overwriteManager.enabled)
            {
                overwriteManager.killVars(param1, this.vars, this.tweens, _subTweens, []);
            }
            return;
        }// end function

        public function complete(param1:Boolean = false) : void
        {
            if (!param1)
            {
                if (!_initted)
                {
                    initTweenVals();
                }
                this.startTime = _curTime - this.duration * 1000;
                render(_curTime);
                return;
            }
            if (this.vars.visible != undefined && _isDisplayObject)
            {
                if (!isNaN(this.vars.autoAlpha) && this.target.alpha == 0)
                {
                    this.target.visible = false;
                }
                else if (this.vars.runBackwards != true)
                {
                    this.target.visible = this.vars.visible;
                }
            }
            if (this.vars.persist != true)
            {
                removeTween(this);
            }
            if (this.vars.onComplete != null)
            {
                this.vars.onComplete.apply(null, this.vars.onCompleteParams);
            }
            return;
        }// end function

        public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return (-param3) * _loc_5 * (param1 - 2) + param2;
        }// end function

        public static function frameProxy(param1:Object) : void
        {
            param1.info.target.gotoAndStop(Math.round(param1.target.frame));
            return;
        }// end function

        public static function removeTween(param1:TweenLite = null) : void
        {
            if (param1 != null && _all[param1.target] != undefined)
            {
                _all[param1.target][param1] = null;
                delete _all[param1.target][param1];
            }
            return;
        }// end function

        public static function killTweensOf(param1:Object = null, param2:Boolean = false) : void
        {
            var _loc_3:Object = null;
            var _loc_4:* = undefined;
            if (param1 != null && _all[param1] != undefined)
            {
                if (param2)
                {
                    _loc_3 = _all[param1];
                    for (_loc_4 in _loc_3)
                    {
                        
                        _loc_3[_loc_4].complete(false);
                    }
                }
                delete _all[param1];
            }
            return;
        }// end function

        public static function delayedCall(param1:Number, param2:Function, param3:Array = null) : TweenLite
        {
            return new TweenLite(param2, 0, {delay:param1, onComplete:param2, onCompleteParams:param3, overwrite:false});
        }// end function

        public static function from(param1:Object, param2:Number, param3:Object) : TweenLite
        {
            param3.runBackwards = true;
            return new TweenLite(param1, param2, param3);
        }// end function

        public static function executeAll(event:Event = null) : void
        {
            var _loc_3:Dictionary = null;
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_6:* = getTimer();
            _curTime = getTimer();
            var _loc_2:* = _loc_6;
            if (_listening)
            {
                _loc_3 = _all;
                for each (_loc_4 in _loc_3)
                {
                    
                    for (_loc_5 in _loc_4)
                    {
                        
                        if (_loc_4[_loc_5] != undefined && _loc_4[_loc_5].active)
                        {
                            _loc_4[_loc_5].render(_loc_2);
                        }
                    }
                }
            }
            return;
        }// end function

        public static function volumeProxy(param1:Object) : void
        {
            param1.info.target.soundTransform = param1.target;
            return;
        }// end function

        public static function killGarbage(event:TimerEvent) : void
        {
            var _loc_3:Boolean = false;
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_2:uint = 0;
            for (_loc_4 in _all)
            {
                
                _loc_3 = false;
                for (_loc_5 in _all[_loc_4])
                {
                    
                    _loc_3 = true;
                    break;
                }
                if (!_loc_3)
                {
                    delete _all[_loc_4];
                    continue;
                }
                _loc_2 = _loc_2 + 1;
            }
            if (_loc_2 == 0)
            {
                _timer.removeEventListener("timer", killGarbage);
                _timer.stop();
                _listening = false;
            }
            return;
        }// end function

        public static function tintProxy(param1:Object) : void
        {
            var _loc_2:* = param1.target.progress;
            var _loc_3:* = 1 - _loc_2;
            var _loc_4:* = param1.info.color;
            var _loc_5:* = param1.info.endColor;
            param1.info.target.transform.colorTransform = new ColorTransform(_loc_4.redMultiplier * _loc_3 + _loc_5.redMultiplier * _loc_2, _loc_4.greenMultiplier * _loc_3 + _loc_5.greenMultiplier * _loc_2, _loc_4.blueMultiplier * _loc_3 + _loc_5.blueMultiplier * _loc_2, _loc_4.alphaMultiplier * _loc_3 + _loc_5.alphaMultiplier * _loc_2, _loc_4.redOffset * _loc_3 + _loc_5.redOffset * _loc_2, _loc_4.greenOffset * _loc_3 + _loc_5.greenOffset * _loc_2, _loc_4.blueOffset * _loc_3 + _loc_5.blueOffset * _loc_2, _loc_4.alphaOffset * _loc_3 + _loc_5.alphaOffset * _loc_2);
            return;
        }// end function

        public static function to(param1:Object, param2:Number, param3:Object) : TweenLite
        {
            return new TweenLite(param1, param2, param3);
        }// end function

    }
}
