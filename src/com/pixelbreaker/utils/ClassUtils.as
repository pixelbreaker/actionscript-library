package com.pixelbreaker.utils
{
	public class ClassUtils
	{
		public static function testAbstract( obj:*, className:String ):void
		{
			if( obj.toString() == '[object ' + className + ']' ) throw new Error( className + ' is an abstract and must be extended' );
		}
	}
}