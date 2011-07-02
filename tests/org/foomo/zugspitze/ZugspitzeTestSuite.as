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
package org.foomo.zugspitze
{
	import org.foomo.zugspitze.utils.ArrayUtilsTest;
	import org.foomo.zugspitze.utils.ClassUtilsTest;
	import org.foomo.zugspitze.utils.DisplayObjectContainerUtilsTest;
	import org.foomo.zugspitze.utils.DisplayObjectUtilsTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	
	/**
	 * @link www.foomo.org
	 * @license www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public class ZugspitzeTestSuite
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		public var test1:org.foomo.zugspitze.utils.ArrayUtilsTest;
		public var test2:org.foomo.zugspitze.utils.ClassUtilsTest;
		public var test3:org.foomo.zugspitze.utils.DisplayObjectContainerUtilsTest;
		public var test4:org.foomo.zugspitze.utils.DisplayObjectUtilsTest;
	}
}