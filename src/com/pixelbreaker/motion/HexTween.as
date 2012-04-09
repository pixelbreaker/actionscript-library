package com.pixelbreaker.motion
{
	import com.pixelbreaker.accessors.PropertyAccessor;
	
	public class HexTween extends HexTweenAccessor implements IAnimate
	{
		public function HexTween( scope:Object, property:String, end:uint, duration:Number, easing:Function = null, delay:Number = 0, ex1:Number = NaN, ex2:Number = NaN )
		{
			super( new PropertyAccessor( scope, property ), end, duration, easing, delay, ex1, ex2);
		}
	}
}