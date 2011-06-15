package org.foomo.zugspitze.utils
{
	//[ExcludeClass]
	public class ArrayUtils
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *  Ensures that an Object can be used as an Array.
		 */
		public static function toArray(obj:Object):Array
		{
			if (obj == null) {
				return [];
			} else if (obj is Array) {
				return obj as Array;
			} else {
				return [obj];
			}
		}

		/**
		 *  Returns the index of the item in the Array.
		 */
		public static function getItemIndex(item:Object, source:Array):int
		{
			var n:int = source.length;
			for (var i:int = 0; i < n; i++) if (source[i] === item) return i;
			return -1;
		}
	}
}