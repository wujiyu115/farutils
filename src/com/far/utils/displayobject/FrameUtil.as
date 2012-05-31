/*
	帧工具
*/
package  com.far.utils.displayobject{
	import flash.display.MovieClip;
	
	
	/**
		Utilities for determining label positions and adding and removing frame scripts.
		
		@author Mike Creighton
		@author Aaron Clinger
		@version 02/12/10
	*/
	public class FrameUtil {
		
		
		/**
			根据帧名得到数字
			
			@param target: The MovieClip to search for the frame label in.
			@param label: The name of the frame label.
			@return The frame number of the label or <code>-1</code> if the frame label was not found.
		*/
		public static function getFrameNumberForLabel(target:MovieClip, label:String):int {
			var labels:Array = target.currentLabels;
			var l:int        = labels.length;
			
			while (l--)
				if (labels[l].name == label)
					return labels[l].frame;
			
			return -1;
		}
		
		/**
			添加脚本到某帧
			
			@param target: The MovieClip that contains the <code>frame</code>.
			@param frame: The frame to be notified when reached. Can either be a frame number (<code>uint</code>), or the frame label (<code>String</code>).
			@param notify: The function that will be called when the frame is reached.
			@return Returns <code>true</code> if the frame was found; otherwise <code>false</code>.
			@throws ArguementTypeError if you pass a type other than a <code>String</code> or <code>uint</code> to parameter <code>frame</code>.
		*/
		public static function addFrameScript(target:MovieClip, frame:*, notify:Function):Boolean {
			if (frame is String)
				frame = FrameUtil.getFrameNumberForLabel(target, frame);
			else if (!(frame is uint))
				throw new Error('frame');
			
			if (frame == -1 || frame == 0 || frame > target.totalFrames)
				return false;
			
			target.addFrameScript(frame - 1, notify);
			
			return true;
		}
		
		/**
			从帧移除脚本
			
			@param target: The MovieClip that contains the <code>frame</code>.
			@param frame: The frame to remove notification from. Can either be a frame number (<code>uint</code>), or the frame label (<code>String</code>).
			@throws ArguementTypeError if you pass a type other than a <code>String</code> or <code>uint</code> to parameter <code>frame</code>.
		*/
		public static function removeFrameScript(target:MovieClip, frame:*):void {
			if (frame is String)
				frame = FrameUtil.getFrameNumberForLabel(target, frame);
			else if (!(frame is uint))
				throw new Error('frame');
			
			if (frame == -1 || frame == 0 || frame > target.totalFrames)
				return;
			
			target.addFrameScript(frame - 1, null);
		}
	}
}