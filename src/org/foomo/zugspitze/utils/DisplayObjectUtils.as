/*
 * This file is part of the foomo Opensource Framework.
 *
 * The foomo Opensource Framework is free software: you can redistribute it
 * and/or modify it under the terms of the GNU Lesser General Public License as
 * published  by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * The foomo Opensource Framework is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with
 * the foomo Opensource Framework. If not, see <http://www.gnu.org/licenses/>.
 */
package org.foomo.zugspitze.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	[ExcludeClass]

	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
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