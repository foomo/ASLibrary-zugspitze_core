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
	 * A simple command queue where commands can be added or taken from
	 *
	 * @link www.foomo.org
	 * @license www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 * @private
	 */
	public class CommandQueue
	{
		//-----------------------------------------------------------------------------------------
		// ~ Private variables
		//-----------------------------------------------------------------------------------------

		private var _commands:Array = new Array;

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function get hasNext():Boolean
		{
			return this._commands.length > 0;
		}

		public function get next():ICommand
		{
			return this._commands.shift();
		}

		public function push(command:ICommand):void
		{
			this._commands.push(command);
		}

		public function clear():void
		{
			for each (var command:ICommand in this._commands) ClassUtils.callMethodIfType(command, IUnload, 'unload');
			this._commands = new Array;
		}

		public function getCommandAt(index:int):ICommand
		{
			return this._commands[index];
		}
	}
}