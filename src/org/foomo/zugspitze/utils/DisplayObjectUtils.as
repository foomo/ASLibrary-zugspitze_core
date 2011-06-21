package org.foomo.zugspitze.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	[ExcludeClass]
	public class DisplayObjectUtils
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Hirachicaly search for the first occurence of the given parent
		 *
		 * @param child				the child
		 * @param classes			array of classes to be searched
		 * @return 					the searched parent, null if not found
		 */
		public static function getParentByClass(child:DisplayObject, clazz:Class):DisplayObject
		{
			var parent:DisplayObject;
			while (child != null) {
				if (child is clazz) {
					parent = child;
					break;
				}
				child = child.parent;
			}
			return parent;
		}
	}
}