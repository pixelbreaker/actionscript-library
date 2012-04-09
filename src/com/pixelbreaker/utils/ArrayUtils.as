package com.pixelbreaker.utils
{
	public class ArrayUtils
	{
		/**
		 * Returns the average result from an array of numbers only.
		 * 
		 * @usage  	
		 * <code>
		 * import com.pixelbreaker.utils.ArrayUtils;
		 * 
		 * var sample_ar = [1,2,3,4,5,6,7,8,9];
		 * var sampleAverage = ArrayX.average(sample_ar);
		 * </code>
		 * @param   arr	Array
		 * @return  Number, the average of all numbers in the array.
		 */
		public static function average(arr:Array):Number
		{
			var n:Number = 0;
			for( var i:uint = 0; i < arr.length; i++ )
			{
				n+=arr[i];
			}
			return n/arr.length;
		}
		
		
		/**
		 * Chooses random index from Array and returns value of random index
		 * 
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.utils.ArrayUtils;
		 * 
		 * var sample_ar = [1,2,3,4,5,6,7,8,9];
		 * var randomResult = ArrayX.chooseRanom(sample_ar);
		 * </code>
		 * @param   arr	Array
		 * @return  Value of random index
		 */
		public static function chooseRandom(arr:Array):*
		{
			return arr[ Math.floor( Math.random()*arr.length ) ];
		}
		
		
		/**
		 * Add all the values of an array
		 * 
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.utils.ArrayUtils;
		 * 
		 * var sample_ar = [1,2,3,4,5,6,7,8,9];
		 * var sampleTotal = ArrayX.sum(sample_ar);
		 * </code>
		 * @param   arr Array
		 * @return  Total value of array
		 */
		public static function sum( arr:Array ):Number
		{
			var n:Number = 0;
			for(var i:uint = 0; i < arr.length; i++)
			{
				n+=arr[i];
			}
			return n;
		}
		
		/**
		 * Compares two arrays
		 * 
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.utils.ArrayUtils;
		 * 
		 * var sample1_ar = [1,2,3,4,5,6,7,8,9];
		 * var sample2_ar = [1,2,3,4,5,6,7,8,9];
		 * 
		 * var difference_ar = ArrayX.compare(sample1_ar, sample2_ar);
		 * </code>
		 * @param   arr  Array
		 * @param   arr2 Array
		 * @return  Array with differences
		 */
		public static function compare(arr:Array, arr2:Array):Array
		{
		   var its:Array = new Array ();
		   var diffArr:Array = new Array ();
		   var separator:String = "###";
		   var i:uint;
		   var k:uint;
		   var it:*;
		   for ( i = 0; i < arr.length; i++){
			  it = arr[i];
			  for ( k = 0; k < arr2.length; k++){
				 if (arr[i] == arr2[k]){
					it = separator;
					break;
				 }
			  }
			  its.push (it);
		   }
		   for ( i = 0; i < arr2.length; i++){
			  it = arr2[i];
			  for ( k = 0; k < arr.length; k++){
				 if (arr2[i] == arr[k]){
					it = separator;
					break;
				 }
			  }
			  its.push (it);
		   }
		   for (var m:uint = 0; m < its.length; m++){
			  if (its[m] != separator){
				 diffArr.push (its[m]);
			  }
		   }
		   return (diffArr);
		}
		
		/**
		 * Create an exact copy of an array
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.utils.ArrayUtils
		 * 
		 * var sample_ar = [1,2,3,4,5,6,7,8,9];
		 * var copyOfArray = ArrayX.makeCopy(sample_ar);
		 * </code>
		 * @param   arr Array
		 * @return  Array
		 */
		public static function makeCopy(arr:Array):Array
		{
			var tArr:Array = [];
			for( var i:uint = 0; i < arr.length; i++ )
			{
				tArr[ i ] = arr[ i ];
			}
			return tArr;
		}
		
		/**
		 * Find the first index of a value within an array
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.utils.ArrayUtils
		 * 
		 * var sample_ar = ["one","two","three"];
		 * var indexOfTwo = ArrayX.indexOf(sample_ar, "two");
		 * </code>
		 * @param   arr Array
		 * @param   str Value to search for
		 * @return  Number, index of first result
		 */
		public static function indexOf( arr:Array, item:Object ):int
		{
			for( var i:uint = 0; i < arr.length; i++ )
			{
				if( arr[i] == item )
				{
					return i;
				}
			}
			return -1;
		}
		
		/**
		 * Find the last index of a value within an array
		 * @usage   
		 * <code>
		 * import com.pixelbreaker.utils.ArrayUtils
		 * 
		 * var sample_ar = ["one","two","three"];
		 * var indexOfTwo = ArrayX.lastIndexOf(sample_ar, "two");
		 * </code>
		 * @param   arr Array
		 * @param   str Value to search for
		 * @return  Number, index of last result
		 */
		public static function lastIndexOf(arr:Array, item:Object ):int
		{
			for( var i:uint = arr.length-1; i >= 0; i-- )
			{
				if( arr[i] == item )
				{
					return i;
				}
			}
			return -1;
		}
		
		/**
		 * Shuffle an array randomly
		 * @usage  
		 * <code>
		 * import com.pixelbreaker.utils.ArrayUtils
		 * 
		 * var sample_ar = ["one","two","three"];
		 * ArrayX.shuffle(sample_ar);
		 * </code>
		 * @param   arr Array
		 * @return  Void
		 */
		public static function shuffle(arr:Array ):void
		{
			var len:uint = arr.length;
			for( var i:uint = 0; i < len; i++ )
			{
				var rand:uint = Math.floor(Math.random()*len);
				var temp:Array = arr[ i ];
				arr[ i ]  = arr[ rand ];
				arr[ rand ] = temp;
			}
		}
		
		/**
		 * Finds and removes duplicate entries in an array
		 * @usage 
		 * <code>
		 * import com.pixelbreaker.utils.ArrayUtils
		 * 
		 * var sample_ar = ["one","two","three","two","two","three"];
		 * ArrayX.removeDuplicates(sample_ar);
		 * // sample_ar now looks like ["one","two","three"];
		 * </code>
		 * @param   arr 	Array to check for duplicates
		 * @return  Void
		 */
		public static function removeDuplicates( arr:Array ):void
		{
			var i:uint, j:uint;
			for(i=0; i<arr.length; i++)
			{
				for(j=0; j<arr.length; j++)
				{
					if(arr[i] == arr[j] && i!=j)
					{
						arr.splice(j,1);
						j--;
					}
				}
			}
		}
	}
}