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
package org.foomo.zugspitze.events
{
	import flash.events.Event;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class ZugspitzeEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const ZUGSPITZE_CONTROLLER_CHANGE:String 	= "zugspitzeControllerChange";
		public static const ZUGSPITZE_COMPLETE:String 		= "zugspitzeComplete";
		public static const ZUGSPITZE_MODEL_CHANGE:String 			= "zugspitzeModelChange";
		public static const ZUGSPITZE_VIEW_CHANGE:String 			= "zugspitzeViewChange";
		public static const ZUGSPITZE_VIEW_REMOVE:String 			= "zugspitzeViewRemove";
		public static const ZUGSPITZE_VIEW_ADD:String 				= "zugspitzeViewAdd";

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ZugspitzeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function clone():Event
		{
			return new ZugspitzeEvent(this.type, this.bubbles, this.cancelable);
		}
	}
}