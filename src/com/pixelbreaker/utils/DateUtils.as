package com.pixelbreaker.utils
{
	public class DateUtils
	{
		public static function isLeapYear( date:Date ):Boolean
	    {
	        var yr:uint = date.getUTCFullYear();
	        if ((( yr % 4) == 0 ) && (( yr % 100) != 0 ) || (( yr % 400 ) == 0 )){ return true; } else { return false; };
	    }
		
		public static function getDaysInMonth( date:Date ):uint 
	    {
	        var daysInMonth:Array = [31,28,31,30,31,30,31,31,30,31,30,31];
	        if ( isLeapYear( date ) ) daysInMonth[1] = 29;
	        
	        return daysInMonth[ date.month ];
	    }
	    
	    public static function getDateSuffix( date:Date ):String
	    {
	    	var suffix:Array = ['st','nd','rd','th','th','th','th','th','th','th','th','th','th','th','th','th','th','th','th','th','st','nd','rd','th','th','th','th','th','th','th','st'];
	    	
	    	return suffix[ date.date-1 ];
	    }
	    
	    public static function getShortMonthName( date:Date ):String
	    {
	    	var months:Array = [ 'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'];
	    	
	    	return months[ date.month ];	
	    }
	    
	    public static function getShortDayName( date:Date ):String
	    {
	    	var days:Array = [ 'sun','mon','tue','wed','thur','fri','sat'];
	    	
	    	return days[ date.day ];	
	    }
	    
	    public static function fromPHPDateTime( datetime:String ):Date
	    {
	    	var spcSplit:Array = datetime.split( ' ' );
	    	var yyyymmdd:Array = spcSplit[ 0 ].split( '-' );
	    	var hhmmss:Array = spcSplit[ 1 ].split( ':' );
	    	
	    	return new Date(
	    		yyyymmdd[ 0 ],
	    		yyyymmdd[ 1 ],
	    		yyyymmdd[ 2 ],
	    		hhmmss[ 0 ],
	    		hhmmss[ 1 ],
	    		hhmmss[ 2 ]
	    	);
	    }
	}
}