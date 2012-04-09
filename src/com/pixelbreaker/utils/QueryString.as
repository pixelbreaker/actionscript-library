package com.pixelbreaker.utils
{
	import flash.external.ExternalInterface;
	import flash.system.Security;
	
	public class QueryString
	{
		public static function getValues():Object
		{
			if( ! ExternalInterface.available ) return null;
			
			var queries:Object = {};
			
			if( Security.sandboxType == Security.REMOTE || Security.sandboxType == Security.LOCAL_TRUSTED )
			{
				var qs:String = String( ExternalInterface.call( 'function(){ return document.location.search; }' ) );
				var sp:Array = StringUtils.ltrim( qs, '?' ).split( '&' );
				for( var i:String in sp )
				{
					var t:Array = sp[ i ].split( '=' );
					queries[ t[ 0 ] ] = t[ 1 ];
				}
			}
			return queries;
		}
	}
}