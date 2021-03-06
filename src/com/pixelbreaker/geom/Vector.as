package com.pixelbreaker.geom
{
	import flash.geom.Point;
	import com.pixelbreaker.geom.Vector;
	/**
	 * @author Gabes Bucknall (pixelbreaker@gmail.com)
	 */
	public class Vector 
	{
		private var vx:Number;
		private var vy:Number;
		
		// INSTANCE CONSTRUCTOR
		public function Vector( x:Number=0, y:Number=0 )
		{
			vx = x;
			vy = y;
		}
		
		// STATICS
		private static function rotateMatrix( r:Number ):Array
		{
			var tCos:Number = Math.cos(r);
			var tSin:Number = Math.sin(r);
			return [ [ tCos, tSin ], [ -tSin, tCos ] ];
		}
		
		public static function pointToVector( point:Point ):Vector
		{
			return new Vector( point.x, point.y );
		}
		
		public static function parallelToUnit( vector:Vector, unit:Vector ):Vector
		{
			var tP:Vector = unit.clone();
			var tD:Number = vector.dot( unit );
			tP = tP.mult( tD );
			return tP;
		}
		
		public static function getIntersect( p1:Vector, p2:Vector, p3:Vector, p4:Vector ):Vector
		{
			var a1:Number,
				a2:Number,
				b1:Number,
				b2:Number,
				c1:Number,
				c2:Number;
			var r1:Number,
				r2:Number,
				r3:Number,
				r4:Number;
			var denom:Number,
				offset:Number,
				num:Number;
				
			var sameSign:Function = function( a:Number, b:Number ):Boolean
									{
										return ( a * b ) >= 0;
									};
			
			// Compute a1, b1, c1, where line joining points 1 and 2
			// is "a1 x + b1 y + c1 = 0".
			a1 = p2.y - p1.y;
			b1 = p1.x - p2.x;
			c1 = ( p2.x * p1.y ) - ( p1.x * p2.y );
			
			// Compute r3 and r4.
			r3 = ( ( a1 * p3.x ) + ( b1 * p3.y ) + c1 );
			r4 = ( ( a1 * p4.x ) + ( b1 * p4.y ) + c1 );
			
			// Check signs of r3 and r4. If both point 3 and point 4 lie on
			// same side of line 1, the line segments do not intersect.
			if ( ( r3 != 0 ) && ( r4 != 0 ) && sameSign( r3, r4 ) ) return null;
			
			// Compute a2, b2, c2
			a2 = p4.y - p3.y;
			b2 = p3.x - p4.x;
			c2 = ( p4.x * p3.y ) - ( p3.x * p4.y );
			
			// Compute r1 and r2
			r1 = ( a2 * p1.x ) + ( b2 * p1.y ) + c2;
			r2 = ( a2 * p2.x ) + ( b2 * p2.y ) + c2;
			
			// Check signs of r1 and r2. If both point 1 and point 2 lie
			// on same side of second line segment, the line segments do
			// not intersect.
			if ( r1 != 0 && r2 != 0 && sameSign( r1, r2 ) ) return null;
			
			//Line segments intersect: compute intersection point.
			denom = ( a1 * b2 ) - ( a2 * b1 );
			
			if (denom == 0) return null;
			
			if (denom < 0) 
				offset = -denom / 2; 
			else
				offset = denom / 2 ;
			
			// The denom/2 is to get rounding instead of truncating. It
			// is added or subtracted to the numerator, depending upon the
			// sign of the numerator.
			num = ( b1 * c2 ) - ( b2 * c1 );
			
			var intersect:Vector = new Vector();
			if (num < 0)
				intersect.x = (num - offset) / denom;
			else
				intersect.x = (num + offset) / denom;
			
			num = ( a2 * c1 ) - ( a1 * c2 );
			if (num < 0)
				intersect.y = ( num - offset) / denom;
			else
				intersect.y = (num + offset) / denom;
			
			return intersect;
	    }
	    
	    public static function getIntersectBoolean( v1:Vector, v2:Vector, v3:Vector, v4:Vector ):Boolean
	    {
	    	var intersect:Vector = getIntersect( v1, v2, v3, v4 );
	    	if( intersect == null ) return false;
	    	return true;	    	
	    }

		
		
		// TRANFORM
		public function rot90( dir:int = 1 ):void
		{
			var tmp:Vector = clone();
			if( dir > 0 )
			{
				vx = -tmp.vy;
				vy = tmp.vx;	
			}
			else
			{
				vx = tmp.vy;
				vy = -tmp.vx;	
			}
		}
		
		public function rotate( r:Number ):void
		{
			var tmp:Vector = clone();
			var rMat:Array = rotateMatrix( r );
			vx = ( tmp.x * rMat[ 0 ][ 0 ] ) + ( tmp.y * rMat[ 1 ][ 0 ] );	
			vy = ( tmp.x * rMat[ 0 ][ 1 ] ) + ( tmp.y * rMat[ 1 ][ 1 ] );
		}
		
		// BASICS
		public function add( v:Vector ):Vector
		{
			return new Vector( vx + v.x, vy + v.y );
		}
		
		public function sub( v:Vector ):Vector
		{
			return new Vector( vx - v.x, vy - v.y );
		}
		
		public function mult( n:Number ):Vector
		{
			return new Vector( vx * n, vy * n );	
		}
		
		public function difference( v:Vector ):Vector
		{
			return length > v.length? sub( v ) : v.sub( this );
		}
		
		public function div( n:Number ):Vector
		{
			return new Vector( vx / n, vy / n );	
		}
		
		public function unit():Vector
		{
			var l:Number = length;
			return new Vector( vx / l, vy / l );
		}
		
		public function dot( v:Vector ):Number
		{
			return ( vx * v.x ) + ( vy * v.y );
		}
		
		// OTHER
		public function clone():Vector
		{
			return new Vector( vx, vy );
		}
		
		public function toString():String
		{
			return '( x=' + x + ', y=' + y + ' )';	
		}
		
		
		// GETTERS & SETTERS
		public function get x():Number
		{
			return vx;
		}
		
		public function set x( val:Number ):void
		{
			vx = val;	
		}

		public function get y():Number
		{
			return vy;
		}
		
		public function set y( val:Number ):void
		{
			vy = val;	
		}
		
		public function get length():Number
		{
			return Math.sqrt( vx*vx + vy*vy );
		}
	}
}
