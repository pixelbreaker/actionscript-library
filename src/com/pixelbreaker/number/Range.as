package com.pixelbreaker.number
{
	public class Range
	{
		public var high:Number;
		public var low:Number;
		
		/**
		 * An number range, represented by a low and high property
		 * 
		 * @usage
		 * <code>
		 * import com.pixelbreaker.number.Range;
		 * 
		 * var myrange:Range = new Range( 10, 200 );
		 * </code>
		 * 
		 * @param low Low end of the range
		 * @param high High end of the range
		 */
		public function Range( low:Number, high:Number )
		{
			this.low = low;
			this.high = high;
		}
		
		/**
		 * Check against another range to see if it overlaps at all
		 * 
		 * @usage
		 * <code>
		 * var myrange:Range = new Range( 10, 200 );
		 * myrange.overlap( new Range( 190, 300 ) ); 	// returns true
		 * myrange.overlap( new Range( 201, 300 ) ); 	// returns false
		 * </code>
		 * 
		 * @param range A Range instnace
		 * @return Boolean
		 */
		public function overlap( range:Range ):Boolean
		{
			if( 
				( low >= range.low && low <= range.high ) || 
				( high >= range.low && high <= range.high ) ||
				( low <= range.low && high >= range.high ) 
			)
			{
				return true;
			}
			return false;
		}
		
		/**
		 * Check against a number to see if it's within this range
		 * 
		 * @usage
		 * <code>
		 * var myrange:Range = new Range( 10, 200 );
		 * myrange.within( 15 ); 	// returns true
		 * myrange.within( 4 ); 	// returns false
		 * </code>
		 * 
		 * @param num Number to check
		 * @return Boolean
		 */
		public function within( num:Number ):Boolean
		{
			if( num >= low && num <= high )
			{
				return true;
			}
			return false;
		}
		
		public function get length():Number
		{
			return high - low;	
		}
	}
}