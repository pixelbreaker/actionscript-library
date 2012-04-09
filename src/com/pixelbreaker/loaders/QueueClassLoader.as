package com.pixelbreaker.loaders
{
	import flash.system.ApplicationDomain;
	import flash.errors.IllegalOperationError;
	
	public class QueueClassLoader extends QueueLoader
	{
		public function QueueClassLoader()
		{
		}
		
		public function getClass( className:String ):Class
		{
			var ad:ApplicationDomain = contentLoaderInfo.applicationDomain;
			try {
				return ad.getDefinition( className ) as Class;
			} catch (e:Error) {
				throw new IllegalOperationError( className + " definition not found in " + contentLoaderInfo.url );
			}
			return null;
		}
	}
}