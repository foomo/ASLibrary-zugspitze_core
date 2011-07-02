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
package org.foomo.zugspitze.managers
{
	import org.foomo.zugspitze.commands.ICommand;

	import flash.events.IEventDispatcher;

	/**
	 *  @eventType org.foomo.zugspitze.events.CommandEvent.COMMAND_ERROR
	 */
	[Event(name="commandError", type="org.foomo.zugspitze.events.CommandEvent")]
	/**
	 *  @eventType org.foomo.zugspitze.events.CommandEvent.COMMAND_COMPLETE
	 */
	[Event(name="commandComplete", type="org.foomo.zugspitze.events.CommandEvent")]

	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	internal interface ICommandManager extends IEventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Singleton initalization
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		function ICommandManager(historyName:String, historySize:Number)

		//-----------------------------------------------------------------------------------------
		// ~ Command History
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value			history identifier
		 */
		function set historyName(value:String):void

		/**
		 * @return				history identifier
		 */
		function get historyName():String

		/**
		 * @param value 		undo history size
		 */
		function set historySize(value:int):void

		/**
		 * @return 				undo history size
		 */
		function get historySize():int

		/**
		 * @return				has undoable command in history
		 */
		function get undoAble():Boolean

		/**
		 * @return 				has redoable command in history
		 */
		function get redoAble():Boolean

		//-----------------------------------------------------------------------------------------
		// ~ Public static mehtods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value 			Execute command through queue
		 */
		function execute(command:ICommand):void

		/**
		 * Undo command in history
		 */
		function undo():void

		/**
		 * Redo command in history
		 */
		function redo():void
	}
}