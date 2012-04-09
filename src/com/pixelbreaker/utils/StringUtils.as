package com.pixelbreaker.utils
{
	import com.pixelbreaker.number.Range;
	
	public class StringUtils
	{
		/**
		 * Clips a string and adds trailing characters 
		 * e.g This is some clipped tex...
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.utils.StringUtils
		 * 
		 * var clippedStr = StringX.clip("a string of text to clip", 20, "...");
		 * </code>
		 * @param   str   The String to clip
		 * @param   ln    Length at which to clip
		 * @param   trail Trailing characters e.g "..."
		 * @return  The clipped string
		 */
		public static function clip(str:String, ln:Number, trail:String):String
		{
			return (str.length > ln? str.substring(0,str.substring(0,ln).lastIndexOf(" "))+trail : str);
		}
	
		/**
		 * Get the ranges of characters used in a string, in ASCII
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.utils.StringUtils
		 * 
		 * var range:Object = StringX.getCharCodeRange("dklamsldkmfsd");
		 * </code>
		 * @param   str String
		 * @return  A Range instance
		 */
		public static function getCharCodeRange(str:String):Range
		{
			var min:uint, max:uint, currCode:uint;
			for(var i:uint=0; i<str.length; i++){
				currCode = str.charCodeAt(i);
				if(i==0){
					min = max = currCode;
				}else{
					if(currCode < min) min = currCode;
					else if(currCode > max) max = currCode;
				}
			}
			return new Range( min, max );
		}
		
		/**
		 * HTML encode characters within a string
		 *
		 * @param   str String
		 * @return  String with HTML encoding
		 */
		public static function htmlEncode(str:String):String
		{
			var s:String = str;
			var a:Array = s.split('&');
			s = a.join('&amp;');
			a = s.split(' ');
			s = a.join('&nbsp;');
			a = s.split('<');
			s = a.join('&lt;');
			a = s.split('>');
			s = a.join('&gt;');
			a = s.split('"');
			s = a.join('&quot;');
			a = s.split('£');
			s = a.join('&pound;');
			return s;
		}
		
		/**
		 * HTML unencode characters within a string
		 *
		 * @param   str String
		 * @return  String without HTML encoding
		 */
		public static function htmlUnencode(str:String):String
		{
			var s:String = str;
			var a:Array = s.split('&amp;');
			s = a.join('&');
			a = s.split('&nbsp;');
			s = a.join(' ');
			a = s.split('&apos;');
			s = a.join("'");	
			a = s.split('&eq;');
			s = a.join('=');
			a = s.split('&lt;');
			s = a.join('<');
			a = s.split('&gt;');
			s = a.join('>');
			a = s.split('&quot;');
			s = a.join('"');
			a = s.split('&pound;');
			s = a.join('£');
			return s;
		}
		
		/**
		 * Convert PC line breaks to UNIX
		 * @param   str String
		 * @return  String with UNIX linefeeds
		 */
		public static function PC2Unix(str:String):String
		{ // Replace New Line with Line Feed //
			return str.split("\r\n").join("\n");
		}
		
		/**
		 * Replace text in a string with another string
		 * 
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.utils.StringUtils
		 * 
		 * var str = "A string of text";
		 * var replacedStr = StringX.replace(str, "of text", "of rope");
		 * </code>
		 * @param   str String to search
		 * @param   f   String to find
		 * @param   r   String to replace with
		 * @return  String
		 */
		public static function replace(str:String, f:String, r:String):String
		{
			return (f == r? str : str.split(f).join(r));
		}
		
		/**
		 * Convert a string to sentence case
		 * @param   str String
		 * @return  String
		 */
		public static function toSentenceCase(str:String):String
		{ // In early dev
			var buildStr:String = "";
			for(var i:uint=0; i<str.length; i++){
				if(i==0) buildStr += str.substring(i,i+1).toUpperCase();
				else if(str.substring(i-2,i-1) == ".") buildStr += str.substring(i,i+1).toUpperCase();
				else buildStr += str.substring(i,i+1);//.toLowerCase();
			}
			return buildStr;
		}
		
		/**
		 * Remove the whitespace (including linefeeds) from either end of a string
		 * @param   str 	String: the text to clean
		 * @return  String
		 */
		public static function removeWhiteSpace(str:String):String
		{
			var tS:String = str;
			while(tS.charAt(0) == " " || tS.charAt(0) == "\n" || tS.charAt(0) == "\r")
			{
				tS = tS.substring(1,tS.length);
			}
			
			while(tS.charAt(tS.length-1) == " " || tS.charAt(tS.length-1) == "\n" || tS.charAt(tS.length-1) == "\r")
			{
				tS = tS.substring(0,tS.length-1);
			}
			
			return tS;
		}
		
		/**
		 * Get the extension of a filename, if none "" is returned
		 * @param   filename 	String: the filename to use
		 * @return  String
		 */
		public static function getFileExt( filename:String ):String
		{
			return filename.lastIndexOf( "." )==-1? "" : filename.substring( filename.lastIndexOf( "." )+1, filename.length ).toLowerCase();
		}
		
		/**
		* static public method, remove spaces from right
		* @param        String  string to parse
		* @return       String  parsed string
		*/
		public static function rtrim( s:String, char:String ):String
		{
			var c:String = char || " ";
			var a:Number = new Number( s.length );
			while( s.substr( a--, 1 ) == c ) {}
			return s.substr( 0, ( a + 1 ) );
		}
	
		/**
		* static public method, remove spaces from left
		* @param        String  string to parse
		* @return       String  parsed string
		*/
		public static function ltrim( s:String, char:String ):String
		{
			var c:String = char || " ";
			var a:Number = 0;
			while( s.substr( a++, 1 ) == c ) {}
			return s.substr( ( a - 1 ), ( s.length ) );
		}
	
		/**
		* static public method, remove spaces from left and right
		* @param        String  string to parse
		* @return       String  parsed string
		*/
		public static function trim( s:String, char:String ):String
		{
			var c:String = char || " ";
			return StringUtils.ltrim( StringUtils.rtrim( s, c ), c );
		}
		
		/**
		 * Test a string for emptiness
		 * 
		 * @usage
		 * @param   str		The string to test
		 * @return  Boolean
		 */
		public static function isEmpty( str:String ):Boolean
		{
			return ( str == "" || str == null || str == "\n" || str == "\n\r" || str == "\r\n" );
		}
		
		/**
		* static public method, add slashes in a string
		* @param        String  string to parse
		* @return       String  parsed string
		*/
		public static function addslashes( s:String ):String {
			return s.split( '"' ).join( '\\"' ).split( "'" ).join( "\\'" );
		}
	
		/**
		* static public method, remove slashes in a string
		* @param        String  string to parse
		* @return       String  parsed string
		*/
		public static function stripslashes( s:String ):String {
			return s.split( '\\' ).join( '' );
		}
	}
}