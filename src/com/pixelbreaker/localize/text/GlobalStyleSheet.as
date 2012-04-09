package com.pixelbreaker.localize.text
{
	import flash.text.StyleSheet;
	import com.pixelbreaker.text.StyleSheetFixed;
	
	public class GlobalStyleSheet extends StyleSheetFixed
	{
		private static var instance:GlobalStyleSheet;
		
		public var loaded:Boolean;
		
		public static function getInstance():GlobalStyleSheet
		{
			if( instance == null ) instance = new GlobalStyleSheet( new SingletonEnforcer() );
			return instance;
		}
		
		public function GlobalStyleSheet( pvt:SingletonEnforcer )
		{
			loaded = false;
		}
		
		public override function parseCSS(CSSText:String):void
		{
			super.parseCSS( CSSText );
			loaded = true;
		}
	}
}

internal class SingletonEnforcer{}