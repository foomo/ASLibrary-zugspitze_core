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
	import org.foomo.core.Managers;
	import org.foomo.zugspitze.commands.ICommand;

	/**
	 * The command manager handles commands.
	 * It executes them after each other and if possible adds them to the history
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class CommandManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		{
			Managers.registerClass('org.foomo.zugspitze.managers::ICommandManager', CommandManagerImpl);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const DEFAULT_STACK:String 		= 'defaultStack';
		public static const DEFAULT_STACK_SIZE:Number 	= 10;

		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static var _impl:ICommandManager;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton instance
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static function get impl():ICommandManager
		{
			if (!_impl) _impl = ICommandManager(Managers.getInstance("org.foomo.zugspitze.managers::ICommandManager"));
			return _impl;
		}

		/**
		 * @return ICommandManager
		 */
		public static function getInstance():ICommandManager
		{
			return impl;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Command History
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value			history identifier
		 */
		public static function set historyName(value:String):void
		{
			impl.historyName = value;
		}

		/**
		 * @return				history identifier
		 */
		public static function get historyName():String
		{
			return impl.historyName;
		}

		/**
		 * @param value 		undo history size
		 */
		public static function set historySize(value:int):void
		{
			impl.historySize = value;
		}

		/**
		 * @return 				undo history size
		 */
		public static function get historySize():int
		{
			return impl.historySize;
		}

		/**
		 * @return				has undoable command in history
		 */
		public static function get undoAble():Boolean
		{
			return impl.undoAble;
		}

		/**
		 * @return 				has redoable command in history
		 */
		public static function get redoAble():Boolean
		{
			return impl.redoAble;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static mehtods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value 			Execute command through queue
		 */
		public static function execute(command:ICommand):void
		{
			impl.execute(command);
		}

		/**
		 * Undo command in history
		 */
		public static function undo():void
		{
			impl.undo();
		}

		/**
		 * Redo command in history
		 */
		public static function redo():void
		{
			impl.redo();
		}

		/**
		 * Add event listner
		 */
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			impl.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * Remove event listner
		 */
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			impl.removeEventListener(type, listener, useCapture);
		}
	}
}