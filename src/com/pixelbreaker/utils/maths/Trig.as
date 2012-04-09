package com.pixelbreaker.utils.maths
{
	import flash.geom.Point;
	
	/**
	 * Triganometric functions
	 * 
	 * @author Gabriel Bucknall
	 * @version 1.0
	 * @since 27/09/2005
	 */
	public class Trig 
	{
		private static var pi180:Number = Math.PI/180;
		/**
		 * Converts an angle in Degrees to Radians
		 * @param   num 	Number: An angle in Degrees
		 * @return  Number, the angle in Radians
		 */
		public static function toRadians (num:Number):Number
		{
			return num * pi180;
		}
		
		/**
		 * Converts an angle in Radians to Degrees
		 * @param   num 	Number: An angle in Radians
		 * @return  Number, the angle in Degrees
		 */
		public static function toDegrees (num:Number):Number
		{
			return num / pi180;
		}
		
		/**
		 * Returns the distance between two Objects's co-ordinates
		 * @usage   
		 * @param   p1 		Object: first
		 * @param   p2 		Object: second
		 * @return  Number
		 */
		public static function getDistance (p1:Object, p2:Object):Number
		{
			var a : Number = p1.x - p2.x;
			var b : Number = p1.y - p2.y;
			var c : Number = Math.sqrt ((a * a) + (b * b));
			return c;
		}
		
		public static function getAngle (p1:Object, p2:Object, returnRads:Boolean):Number
		{
			var theta:Number = Math.atan2 (p1.x - p2.x , p1.y - p2.y);
			if( returnRads ) return theta;
			theta /= Math.PI / 180;
	//		theta = (theta + 360) % 360;
			return theta;
		}
		
		/**
		 * Gets the x,y coordinates of a Vector
		 * @param   startX		Number: starting X
		 * @param   startY 		Number: starting Y
		 * @param   thetha 		Number: Angle of vector projection in Radians
		 * @param   r      		Number: Radius of vector projection in pixels
		 * @return  Object with x and y properties.
		 */
		public static function getVectorPoint(startX:Number, startY:Number, thetha:Number, r:Number):Point
		{
			var p:Point = new Point( (startX + r * Math.cos(thetha)), (startY + r * Math.sin(thetha)) );
			return p;
		}
	}
}