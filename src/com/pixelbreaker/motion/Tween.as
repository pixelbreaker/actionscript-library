package com.pixelbreaker.motion
{
	import com.pixelbreaker.accessors.PropertyAccessor;
	
	public class Tween extends TweenAccessor implements IAnimate
	{
		public function Tween( scope:Object, property:String, end:Number, duration:Number, easing:Function = null, delay:Number = 0, ex1:Number = NaN, ex2:Number = NaN )
		{
			super( new PropertyAccessor( scope, property ), end, duration, easing, delay, ex1, ex2);
		}
		
	}
}