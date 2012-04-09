package com.pixelbreaker.motion
{
	import com.pixelbreaker.animation.easing.Linear;	
	public class MotionSettings
	{
		public static var PIXEL_SNAPPING		:Boolean = false;
	
	 	public static var DEFAULT_EASING		:Function = Linear.easeNone;
		
		public static var FRICTION_RATE			:Number = 0.1;
		public static var FRICTION_FRICTION		:Number = 0.2;
		public static var FRICTION_PRECISION	:Number = 0.001;
	}
}