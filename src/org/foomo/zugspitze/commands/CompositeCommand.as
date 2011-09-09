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
	import flash.utils.getQualifiedClassName;

	import org.foomo.memory.IUnload;
	import org.foomo.zugspitze.events.CommandEvent;
	import org.foomo.managers.LogManager;
	import org.foomo.utils.ClassUtil;

	/**
	 * Executes several commands in a closed sequence.
	 *
	 * <p>To execute several commands in one command sequence you first need
	 * to add all command by calling addCommand() and then execute the sequence by
	 * calling executeSequence().</p>
	 *
	 * <p>There should be enough possibilities to hook you in if you need to.</p>
	 *
	 * <p>It is not recommended to add commands after the executeSequence() has been called!</p>
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class CompositeCommand extends Command implements IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _function:String;

		private var _undoable:Boolean = true;

		protected var _pendingCommand:ICommand;

		protected var _commandQueue:CommandQueue = new CommandQueue;

		protected var _executedCommands:Array = new Array;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CompositeCommand(showBusyCursor:Boolean=false)
		{
			super(showBusyCursor);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function unload():void
		{
			var cmd:ICommand;

			for each (cmd in this._commandQueue) ClassUtil.callMethodIfType(cmd, IUnload, 'unload');
			this._commandQueue = null;

			for each (cmd in this._executedCommands) ClassUtil.callMethodIfType(cmd, IUnload, 'unload');
			this._executedCommands = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value			command to be added to the sequence
		 */
		protected function addCommand(value:ICommand):ICommand
		{
			this._commandQueue.push(value);
			return value;
		}

		/**
		 * Call this to start the sequence
		 */
		protected function executeSequence():void
		{
			this._function = 'execute';
			this.nextCommand();
		}

		/**
		 * Call this to start the sequence
		 */
		protected function undoSequence():void
		{
			if (this._commandQueue.hasNext || this._executedCommands.length == 0 || !this._undoable) throw new Error('Sequence is not undoable');

			while (this._executedCommands.length > 0 ) {
				this.addCommand(this._executedCommands.pop());
			}

			this._function = 'undo';

			this.nextCommand();
		}

		/**
		 * Call this to start the sequence
		 */
		protected function redoSequence():void
		{
			if (this._commandQueue.hasNext || this._executedCommands.length == 0 || !this._undoable) throw new Error('Sequence is not redoable');

			while (this._executedCommands.length > 0 ) {
				this.addCommand(this._executedCommands.shift());
			}

			this._function = 'redo';

			this.nextCommand();
		}

		/**
		 * You may want to overwrite this in order to do stuff
		 */
		protected function sequenceComplete():void
		{
			this.dispatchCommandCompleteEvent();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 * Excute command from queue
		 */
		private function nextCommand():void
		{
			if (this._commandQueue.hasNext) {
				this._pendingCommand = this._commandQueue.next;
				this._pendingCommand.addEventListener(CommandEvent.COMMAND_COMPLETE, this.commandCompleteHandler);
				this._pendingCommand.addEventListener(CommandEvent.COMMAND_ERROR, this.commandErrorHandler);
				if (LogManager.isDebug()) LogManager.debug(this, 'Executing subcommand :: ' + getQualifiedClassName(this._pendingCommand));
				this._pendingCommand[this._function]();
			} else {
				this.sequenceComplete();
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected Eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		protected function commandCompleteHandler(event:CommandEvent):void
		{
			if (LogManager.isDebug()) LogManager.debug(this, 'Executed subcommand  :: ' + Command(this._pendingCommand).toString());
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_COMPLETE, this.commandCompleteHandler);
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_ERROR, this.commandErrorHandler);
			if (this._pendingCommand is IRedoableCommand && this._pendingCommand is IUndoableCommand) {
				this._executedCommands.push(this._pendingCommand);
			} else {
				this._undoable = false;
			}
			this._pendingCommand = null;
			this.nextCommand();
		}

		/**
		 * @private
		 */
		protected function commandErrorHandler(event:CommandEvent):void
		{
			if (LogManager.isDebug()) LogManager.debug(this, 'Fault on subcommand  :: ' + Command(this._pendingCommand).toString());
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_COMPLETE, this.commandCompleteHandler);
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_ERROR, this.commandErrorHandler);
			this._commandQueue 		= null;
			this._executedCommands 	= null;
			this._pendingCommand 	= null;
			this.dispatchCommandErrorEvent();
		}
	}
}