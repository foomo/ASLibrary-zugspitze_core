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
	 * @license www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
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