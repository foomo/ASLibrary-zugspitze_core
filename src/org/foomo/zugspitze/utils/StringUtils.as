package org.foomo.zugspitze.utils
{
	[ExcludeClass]
	public class StringUtils
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * MyString -> myString
		 */
		public static function lcFirst(value:String):String
		{
			return value.substr(0, 1).toLowerCase() + value.substr(1);
		}

		/**
		 * myString -> MyString
		 */
		public static function ucFirst(value:String):String
		{
			return value.substr(0, 1).toUpperCase() + value.substr(1);
		}
	}
}