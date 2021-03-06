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
	import org.foomo.memory.IUnload;
	import org.foomo.utils.ClassUtil;

	[ExcludeClass]

	/**
	 * A simple command stack where commands can be added or taken from
	 *
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 * @private
	 */
	public class CommandStack
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _size:uint;

		/**
		 * @private
		 */
		private var _index:int;

		/**
		 * @private
		 */
		private var _commands:Array;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CommandStack(size:int)
		{
			this._index 	= 0;
			this._size 		= size;
			this._commands 	= new Array;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Adds a new command to the stack
		 *
		 * @param value			command to be added
		 */
		public function put(value:ICommand):void
		{
			//if you were working with undo you have to raise the index after slicing
			//else there is a command in the history you want to be deleted
			if (this._commands[this._index]) {
				this._commands = this._commands.slice(0, this._index++);
			} else {
				this._commands = this._commands.slice(0, ++this._index);
			}
			this._commands.push(value);
			this.validateSize();
		}

		/**
		 * @param value			stack size
		 */
		public function set size(value:uint):void
		{
			this._size = value;
			this.validateSize();
		}

		/**
		 * @return				stack size
		 */
		public function get size():uint
		{
			return this._size;
		}

		/**
		 * @return 				has next command
		 */
		public function get hasNext():Boolean
		{
			return (this._index < this._commands.length);
		}

		/**
		 * @return 				next command in stack
		 */
		public function get next():Command
		{
			this.validateSize();
			return this._commands[this._index++];
		}

		/**
		 * @return 				has previous command
		 */
		public function get hasPrevious():Boolean
		{
			return this._index > 0;
		}

		/**
		 * @return 				previous command in stack
		 */
		public function get previous():Command
		{
			this.validateSize();
			return this._commands[--this._index];
		}

		/**
		 * Cuts the stack back to current index
		 */
		public function cutBack():void
		{
			this._commands = this._commands.slice(0, this._index);
		}

		/**
		 * Resets the stack
		 */
		public function reset():void
		{
			this._index = 0;
			for each (var command:ICommand in this._commands) ClassUtil.callMethodIfType(command, IUnload, 'unload');
			this._commands = new Array();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private function validateSize():void
		{
			if (this._commands.length > this._size) {
				this._commands 	= this._commands.slice((this._commands.length - this._size), this._commands.length);
				this._index 	= this._commands.length;
			}
		}
	}
}