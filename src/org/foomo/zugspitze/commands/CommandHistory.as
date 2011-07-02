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
package org.foomo.zugspitze.commands
{
	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.utils.ClassUtils;

	[ExcludeClass]

	/**
	 * The command history takes executed commands and adds them to a history
	 * if these implement the right interfaces.
	 *
	 * @link www.foomo.org
	 * @license www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 * @private
	 */
	public class CommandHistory
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		/**
		 * Default history stack
		 */
		public static const DEFAULT_HISTORY:String		= 'defaultHistory';

		/**
		 * Default undo history size
		 */
		public static const DEFAULT_HISTORY_SIZE:int	= 10;

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _stacks:Array;

		/**
		 * @private
		 */
		private var _name:String;

		/**
		 * @private
		 */
		private var _size:uint;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CommandHistory(name:String='defaultHistory', size:uint=10)
		{
			this._stacks = new Array;
			this._name = name;
			this._size = size;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value			undo history size
		 */
		public function set size(value:uint):void
		{
			this._size = value;
			for each (var stack:CommandStack in this._stacks) {
				stack.size = this._size;
			}
		}

		/**
		 * @return 				undo history size
		 */
		public function get size():uint
		{
			return this._size;
		}

		/**
		 * Enables you to define different history stacks
		 *
		 * @param value			identifier string
		 */
		public function set name(value:String):void
		{
			this._name = value;
		}

		/**
		 * @return				current history idendifier
		 */
		public function get name():String
		{
			return this._name;
		}

		/**
		 * @return				has undoable command in history
		 */
		public function get hasPrevious():Boolean
		{
			return this.currentStack.hasPrevious;
		}

		/**
		 * @return				undoable command
		 */
		public function get previous():IUndoableCommand
		{
			var cmd:IUndoableCommand = IUndoableCommand(this.currentStack.previous);
			if (!(cmd is IRedoableCommand)) this.currentStack.cutBack();
			return cmd;
		}

		/**
		 * @return 				has redoable command in history
		 */
		public function get hasNext():Boolean
		{
			return this.currentStack.hasNext;
		}

		/**
		 * @return 				redoable command
		 */
		public function get next():IRedoableCommand
		{
			return IRedoableCommand(this.currentStack.next);
		}

		/**
		 * Adds a command to the current history
		 *
		 * <p>If command does not implement the <code>IUndoableCommand</code> interface
		 * the current history stack will be cleared.</p>
		 *
		 *
		 * @param value			command to be added to history
		 */
		public function put(value:ICommand):void
		{
			if (value is IUndoableCommand) {
				this.currentStack.put(value);
			} else {
				ClassUtils.callMethodIfType(value, IUnload, 'unload');
				this.currentStack.reset();
			}
		}

		/**
		 * Clears all histroies
		 *
		 * @param all			if false only current history will be cleared
		 */
		public function clear(all:Boolean=true):void
		{
			if (all) {
				for each (var stack:CommandStack in this._stacks) stack.reset();
			} else {
				this.currentStack.reset();
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		private function get currentStack():CommandStack
		{
			if (this._stacks[this._name] == null) {
				this._stacks[this._name] = new CommandStack(this._size);
			}
			return this._stacks[this._name];
		}
	}
}