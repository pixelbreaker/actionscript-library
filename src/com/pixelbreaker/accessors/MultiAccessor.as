package com.pixelbreaker.accessors
{
	public class MultiAccessor implements IAccessor
	{
		private var accessors:Array;
	
		/**
		 * Create instance of MultiAccessor
		 */
		public function MultiAccessor( ...rest )
		{
			accessors = rest;
		}
		
		/**
		 * Adds an accessor, and accessor that implements the IAccessor interface
		 * 
		 * @usage
		 * <code>
		 * var multiAccessor:MultiAccessor = new MultiAccessor();
		 * 
		 * multiAccessor.addAccessor( new PropertyAccessor( myMovieClip, '_y' ) );
		 * multiAccessor.addAccessor( new PlayheadAccessor( otherMovieClip ) );
		 * </code>
		 * 
		 * @param accessor An instance that implements the IAccessor interface
		 */
		public function addAccessor( accessor:IAccessor ):void
		{
			accessors.push( accessor );	
		}
		
		/**
		 * Set the value of each of the added accessors
		 * 
		 * @param value	The new value of the property
		 */
		public function setValue( value:Object ):void
		{
			for (var i:Number = 0; i < accessors.length; i++)
			{
				PropertyAccessor( accessors[ i ] ).setValue( value );
			}
		}
		
		/**
		 * Get the current playhead position
		 * 
		 * @return value of all accessors added (will all be identical)
		 */
		public function getValue():*
		{
			return PropertyAccessor( accessors[0] ).getValue();
		}
		
		/**
		 * Get the scope of this accessor's property
		 */
		public function getScope():Object
		{
			return this;	
		}
		
		/**
		 * Get the name of this accessor's property (always 'multi')
		 */
		public function getProperty():String
		{
			return 'multi';	
		}
	}
}