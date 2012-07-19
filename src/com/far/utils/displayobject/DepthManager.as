/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package com.far.utils.displayobject{

import flash.display.*;

/**
 * DepthManager to manage the depth of display objects.
 * 层深管理
 * @author iiley
 */
public class DepthManager{
	
	/**
	 * 将mc放到父级的最低层
	 * @param mc the mc to be set to bottom
	 * @see #isBottom()
	 */
	public static function bringToBottom(mc:DisplayObject):void{
		var parent:DisplayObjectContainer = mc.parent;
		if(parent == null){ return; }
		if(parent.getChildIndex(mc) != 0){
			parent.setChildIndex(mc, 0);
		}
	}
	
	/**
	 * 将mc放到父级最顶层
	 */	
	public static function bringToTop(mc:DisplayObject):void{
		var parent:DisplayObjectContainer = mc.parent;
		if(parent == null) return;
		var maxIndex:int = parent.numChildren-1;
		if(parent.getChildIndex(mc) != maxIndex){
			parent.setChildIndex(mc, maxIndex);
		}
	}
	
	/**
	 * 判断 mc是否在最顶端
	 * Valid depths is that depths from MIN_DEPTH to MAX_DEPTH.
	 */
	public static function isTop(mc:DisplayObject):Boolean{
		var parent:DisplayObjectContainer = mc.parent;
		if(parent == null) return true;
		return (parent.numChildren-1) == parent.getChildIndex(mc);
	}
	
	/**
	 * 判断 mc是否在最底端
	 * Returns if the mc is at bottom depth.
	 * @param mc the mc to be set to bottom
	 * @return is the mc is at the bottom
	 */
	public static function isBottom(mc:DisplayObject):Boolean{
		var parent:DisplayObjectContainer = mc.parent;
		if(parent == null) return true;
		var depth:int = parent.getChildIndex(mc);
		if(depth == 0){
			return true;
		}
		return false;
	}
	
	/**
	 * mc是否在同级另一mc下
	 * Return if mc is just first bebow the aboveMC.
	 * if them don't have the same parent, whatever depth they has just return false.
	 */
	public static function isJustBelow(mc:DisplayObject, aboveMC:DisplayObject):Boolean{
		var parent:DisplayObjectContainer = mc.parent;
		if(parent == null) return false;
		if(aboveMC.parent != parent) return false;
		
		return parent.getChildIndex(mc) == parent.getChildIndex(aboveMC)-1;
	}
	
	/**mc是否在同级另一mc上
	 * Returns if mc is just first above the belowMC.
	 * if them don't have the same parent, whatever depth they has just return false.
	 * @see #isJustBelow
	 */	
	public static function isJustAbove(mc:DisplayObject, belowMC:DisplayObject):Boolean{
		return isJustBelow(belowMC, mc);
	}
}
	
}