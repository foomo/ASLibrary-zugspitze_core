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
	[ExcludeClass]
	
	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
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