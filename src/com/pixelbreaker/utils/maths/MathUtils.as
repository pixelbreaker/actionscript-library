package com.pixelbreaker.utils.maths
{
	/**
	 * Math utility class
	 * 
	 * @author  Gabriel Bucknall
	 * @version 1.0
	 * @since   01/04/2005
	 */
	public class MathUtils
	{
		
		/**
		 * Constrain a number to a range
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.math.MathX;
		 * 
		 * var myNum = Math.random()*1000
		 * // to constrain between 500 and 1000
		 * var myConstrained = MathX.constrain(myNum, 500, 1000);
		 * 
		 * </code>
		 * @param   num 	Number: The input
		 * @param   low 	Number: The low end of the range
		 * @param   high  	Number: The high end of the range
		 * @return  Number
		 */
		public static function constrain(num:Number,low:Number,high:Number):Number
		{
			return (num<low)? low : (num>high)? high : num;
		}
		
		/**
		 * Generate a random integer within a range
		 * @usage 
		 * <code>
		 * import com.pixelbreaker.math.MathX;
		 * 
		 * var myNum = MathX.randInt(200,1000);
		 * 
		 * </code>
		 * @param   low  	Number: The low end of the range
		 * @param   high 	Number: The high end of the range
		 * @return  
		 */
		public static function randInt(low:Number, high:Number):Number
		{
			return low + Math.round (Math.random () * (high - low));
		}
		
		/**
		 * Find the shortest direction to spin from one angle to another.
		 * @param   a1	Number: Angle to spin from (in degrees)
		 * @param   a2 	Number: Angle to spin to (in degrees)
		 * @return  Number: the resulting angle (in degrees)
		 */
		public static function shortest360Spin(a1:Number,a2:Number):Number
		{
			var f:Number = a2>a1? a2-a1 : a2+(360-a1);
			var r:Number = a2>a1? a1+(360-a2) : a1-a2;
			return (f<=r)? f : -r;
		}
		
		/**
		 * Constrain an angle to 360
		 * @param   a 	Number: The angle to constrain
		 * @return  Number
		 */
		public static function within360(a:Number):Number
		{
			while(a < 0) a += 360;
			if(a > 360) a %= 360;
			return a;
		}
		
		/**
		 * Return a percentage from 2 numbers
		 * @param   a 	Number: smaller number
		 * @param   b 	Number: larger number
		 * @return  Number
		 */
		public static function percentage(a:Number, b:Number):Number
		{
			return Math.round((a/b)*100);
		}
		
		
		/**
		 * Prefix a number with any number of zeros, useful for navigation labelling etc.
		 * 
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.math.MathX;
		 * 
		 * // would return "012"
		 * var myString = MathX.leadingZero(12, 3)
		 * 
		 * // would return "00045"
		 * var myString = MathX.leadingZero(45, 5)
		 * 
		 * </code>
		 * @param   num     	Number: Input number
		 * @param   digits 		Number: Total number of digits
		 * @return  String
		 */
		public static function leadingZero (num:Number, digits:Number):String
		{
			var $tmpNumber : String = num.toString ();
			var $tmpZeros : String = "";
			for (var $z : Number = 0; $z < (digits - $tmpNumber.length); $z ++) $tmpZeros += "0"; 
			return $tmpZeros + $tmpNumber.toString ();
		}
		
		/**
		 * Round a number to a certain number of decimal places rather than an Integer like Math.round();
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.math.MathX;
		 * 
		 * // would return 45.457
		 * var myString = MathX.roundDec(45.45689123, 3);
		 * 
		 * </code> 
		 * @param   num    	Number: Input number
		 * @param   places 	Number: Number of decimal places to retain
		 * @return  Floating-point Number
		 */
		public static function roundDec( num:Number, places:Number ):Number
		{
			var p:String = "1";
			for (var i:uint = 0; i < places; i ++) p += "0"; 
			var n:Number = Number(p);
			return Math.round(num * n)/n;		
		}
		
		/**
		 * Group digits, useful for currency display
		 * e.g. £12000 becomes £12,000
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.math.MathX;
		 * 
		 * // would return "123,456,789"
		 * var myString = MathX.digitGroup(123456789);
		 * 
		 * </code> 
		 * @param   num       	Number: Input number
		 * @param   seperator 	String: The seperator, "," for UK, "." for Europe
		 * @return  String
		 */
		public static function digitGroup (num:Number, seperator:String):String
		{
			var $tmp : String = num.toString ();
			var $nl : Number = $tmp.length;
			var $iP : Number = ($nl % 3) - 1;
			var $return : String = "";
			for (var $i : Number = 0; $i < $nl; $i ++)
			{
				$return += $i == $iP || ($i - $iP) % 3 == 0 && $i < $nl - 1? $tmp.substring ($i, $i + 1) + seperator : $tmp.substring ($i, $i + 1);
			}
			return $return;
		}
		
		public static function snapTo( value:Number, snapTo:Number, offset:Number = NaN ):Number
		{
			var r:Number;
			if( isNaN( offset ) ){
				r = Math.round(value/snapTo)*snapTo;
			}else{
				r = ( Math.floor(value/snapTo)*snapTo ) + offset;
			}
			return r;
		}
	}
}