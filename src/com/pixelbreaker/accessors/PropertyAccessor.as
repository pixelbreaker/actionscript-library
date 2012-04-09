package com.pixelbreaker.accessors
{
	public class PropertyAccessor implements IAccessor
	{
		
		private var scope:Object;
		private var property:String;
		
		/**
		 * Create a new PropertyAccessor instance
		 * 
		 * @usage
		 * <code>
		 * var xAccessor:PropertyAccessor = new PropertyAccessor( myMovieClip, '_x' );
		 * </code>
		 * 
		 * @param scope		The Object containing the property to access
		 * @param property	The property to access
		 */
		public function PropertyAccessor( scope:Object, property:String )
		{
			this.scope = scope;
			this.property = property;	
		}
		
		/**
		 * Set the value of the instances assigned property
		 * 
		 * @param value	The new value of the property
		 */
		public function setValue( value:Object ):void
		{
			scope[ property ] = value;
		}
		
		/**
		 * Get the value of the instances assigned property
		 * 
		 * @return The value of the property (not typed)
		 */
		public function getValue():*
		{
			return scope[ property ];	
		}
		
		/**
		 * Get the scope of this accessor's property
		 */
		public function getScope():Object
		{
			return scope;	
		}
		
		/**
		 * Get the name of this accessor's property
		 */
		public function getProperty():String
		{
			return property;	
		}
	}
}