package badyoo.badYooFrameWork.core
{
    import flash.events.*;
    import flash.utils.*;

    public class TimerManager extends Object
    {
        private static var _instance:TimerManager;
        private static var _array:Array = new Array();
        private static var callBackList:Object = {};

        public function TimerManager()
        {
            return;
        }// end function

        public static function addTimer(frameRate:int, callBack:Function) : void
        {
            var index:Number;
            var time:Function;
            var timer:Timer;
            var frameRate:* = frameRate;
            var callBack:* = callBack;
            time = function (event:TimerEvent) : void
            {
                var _loc_2:* = callBackList[index];
                var _loc_3:* = _loc_2.length;
                var _loc_4:int = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    var _loc_5:* = _loc_2;
                    _loc_5._loc_2[_loc_4]();
                    _loc_4 = _loc_4 + 1;
                }
                return;
            }// end function
            ;
            if (!_instance)
            {
                _instance = new TimerManager;
            }
            index = Math.ceil(1000 / frameRate);
            if (_array.indexOf(frameRate) == -1)
            {
                timer = new Timer(index);
                timer.addEventListener(TimerEvent.TIMER, time);
                callBackList[index] = [callBack];
                timer.start();
                _array.push(frameRate);
            }
            else
            {
                callBackList[index].push(callBack);
            }
            return;
        }// end function

        public static function removeTimer(frameRate:int, callBack:Function) : void
        {
            if (!_instance)
            {
                _instance = new TimerManager;
            }
            var _loc_3:* = Math.ceil(1000 / frameRate);
            if (_array.indexOf(frameRate) == -1)
            {
                return;
            }
            var _loc_4:* = callBackList[_loc_3];
            var _loc_5:* = _loc_4.indexOf(callBack);
            if (_loc_5 != -1)
            {
                _loc_4.splice(_loc_5, 1);
            }
            return;
        }// end function

    }
}
