package com.pixelbreaker.motion
{
	internal interface IAnimate
	{
		function step():void;
		function stop():void;
		function start():void;
		
		function getTarget():Object;
		function getDelay():uint;
	}
}