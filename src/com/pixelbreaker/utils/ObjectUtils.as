package com.pixelbreaker.utils
{
	public class ObjectUtils
	{
		/**
		 * Return a copy of an object.
		 */
		public static function makeCopy( source:Object ):Object
		{
			var tObj:Object = {};
			for(var i:String in source)
			{
				tObj[i] = source[i];
			}
			return tObj;
		}
		
		/**
		 * Copy properties from a source object to a target object.
		 */
		public static function inheritProperties( target:Object, source:Object ):void
		{
			for(var i:String in source) target[i] = source[i];	
		}
		
		public static function matchProperties( object1:Object, object2:Object ):Boolean
		{
			for( var i:String in object1 )
			{
				if( object1[ i ] != object2[ i ] ) return false;
			}
			return true;
		}
	}
}