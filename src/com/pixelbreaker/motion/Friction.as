package com.pixelbreaker.motion
{
	import com.pixelbreaker.accessors.PropertyAccessor;
	
	public class Friction extends FrictionAccessor
	{
		public function Friction( scope:Object, property:String, rate:Number = NaN, friction:Number = NaN )
		{
			super( new PropertyAccessor( scope, property ), rate, friction );
		}
	}
}