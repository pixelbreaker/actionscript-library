package com.pixelbreaker.utils
{
	public class Validate
	{
		public static function isEmailAddress( address:String ):Boolean
		{
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var result:Object = pattern.exec( address );
			return !( result == null );
		}
		
		public static function isUKPostcode( postcode:String ):Boolean
		{
			var pattern:RegExp = /(GIR 0AA|[A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW]) [0-9][ABD-HJLNP-UW-Z]{2})/;
			var result:Object = pattern.exec( postcode );
			return !( result == null );
		}
	}	
}