package com.pixelbreaker.debug 
{

	import flash.external.ExternalInterface;
	/**
	 * @author Gabes Bucknall (pixelbreaker@gmail.com)
	 */
	public class Firebug 
	{
		public static var ALLOW_DEBUG:Boolean = false;
		
		public static function trace( input:* ):void
		{
			if( ALLOW_DEBUG && ExternalInterface.available )
				ExternalInterface.call( 'console.log', input );
		}
	}
}
