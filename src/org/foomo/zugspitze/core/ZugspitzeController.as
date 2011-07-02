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
package org.foomo.zugspitze.core
{
	import org.foomo.zugspitze.commands.Command;
	import org.foomo.zugspitze.commands.ICommand;
	import org.foomo.zugspitze.managers.CommandManager;

	import flash.events.EventDispatcher;
	import org.foomo.zugspitze.zugspitze_internal;

	/**
	 * Zugspitze Controller.
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class ZugspitzeController extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variabels
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _zugspitze:Zugspitze;

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Undo command in history calling CommandManager.undo()
		 */
		public function undo():void
		{
			CommandManager.undo();
		}

		/**
		 * Redo command in history calling CommandManager.redo()
		 */
		public function redo():void
		{
			CommandManager.redo();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @return 					zugspitze instance
		 */
		protected function get zugspitze():Zugspitze
		{
			return this._zugspitze;
		}

		/**
		 * Executes the command using CommandManager
		 *
		 * @param command			command to be executed
		 * @param queueCommand		execute it using queue
		 * @return 					executed command
		 */
		protected function executeCommand(command:ICommand, queueCommand:Boolean=true):ICommand
		{
			if (queueCommand) {
				CommandManager.execute(command);
			} else {
				command.execute();
			}
			return command;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Internal methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		zugspitze_internal function set zugspitze(value:Zugspitze):void
		{
			this._zugspitze = value;
		}
	}
}