package com.pixelbreaker.accessors
{
	public interface IAccessor
	{
		function setValue( value:Object ):void;
		function getValue():*;
		function getScope():Object;
		function getProperty():String;
	}
}