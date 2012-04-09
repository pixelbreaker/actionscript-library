package com.pixelbreaker.text
{
	import flash.text.StyleSheet;

	public class StyleSheetFixed extends StyleSheet
	{
		public function StyleSheetFixed()
		{
		}
		
		/**
		 * Fixes issue in flash.text.StyleSheet where getStyle always returns an object
		 * even though the documentation says that it would return null when the style
		 * doesn't exist 
		 */ 
		public override function getStyle( styleName:String ):Object
		{
			var s:Object = super.getStyle( styleName );	
			if( s.color == null &&
				 s.display == null &&
				 s.fontFamily == null &&
				 s.fontSize == null &&
				 s.fontWeight == null &&
				 s.kerning == null &&
				 s.leading == null &&
				 s.letterSpacing == null &&
				 s.marginLeft == null &&
				 s.marginRight == null &&
				 s.textAlign == null &&
				 s.textDecoration == null &&
				 s.textIndent == null 
			)
			{
				return null;	
			}
			
			return s;
		}
	}
}