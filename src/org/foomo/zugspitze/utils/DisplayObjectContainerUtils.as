package org.foomo.zugspitze.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	//[ExcludeClass]
	public class DisplayObjectContainerUtils
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function addChild(child:DisplayObject, parent:DisplayObjectContainer):*
		{
			if ('addElement' in parent) {
				return parent['addElement'](child);
			} else {
				return parent.addChild(child);
			}
		}

		/**
		 *
		 */
		public static function removeChild(child:DisplayObject, parent:DisplayObjectContainer):*
		{
			if ('addElement' in parent) {
				return parent['removeElement'](child);
			} else {
				return parent.removeChild(child);
			}
		}
	}
}