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
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	import org.foomo.zugspitze.commands.Command;
	import org.foomo.zugspitze.commands.CommandHistory;
	import org.foomo.zugspitze.commands.CommandQueue;
	import org.foomo.zugspitze.commands.ICommand;
	import org.foomo.zugspitze.commands.IRedoableCommand;
	import org.foomo.zugspitze.commands.IUndoableCommand;
	import org.foomo.flash.core.IUnload;
	import org.foomo.zugspitze.events.CommandEvent;
	import org.foomo.flash.utils.ClassUtil;
	import org.foomo.flash.managers.LogManager;

	[Event(name="commandError", type="org.foomo.zugspitze.events.CommandEvent")]
	[Event(name="commandComplete", type="org.foomo.zugspitze.events.CommandEvent")]
	//[ExcludeClass]

	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public class CommandManagerImpl extends EventDispatcher implements ICommandManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Private variables
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private static var _instance:ICommandManager;

		/**
		 * @private
		 */
		private var _commandQueue:CommandQueue;

		/**
		 * @private
		 */
		private var _commandHistory:CommandHistory;

		/**
		 * @private
		 * Current pending command
		 */
		private var _pendingCommand:Command;

		/**
		 * @private
		 * Flag if a command is pending
		 */
		private var _pending:Boolean 	= false;

		/**
		 * @private
		 * Flag if the command manager has set an busy cursor
		 */
		private var _busySet:Boolean 	= false;

		/**
		 * @private
		 * Give time for debugging
		 */
		private var _time:Number;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton constructor
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		public function CommandManagerImpl(historyName:String, historySize:Number)
		{
			this._commandQueue 		= new CommandQueue;
			this._commandHistory 	= new CommandHistory(historyName, historySize);
		}

		/**
		 * @private
		 */
		public static function getInstance():ICommandManager
		{
			if (!_instance) _instance = new CommandManagerImpl(CommandManager.DEFAULT_STACK, CommandManager.DEFAULT_STACK_SIZE);
			return _instance;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value			history identifier
		 */
		public function set historyName(value:String):void
		{
			this._commandHistory.name = value;
		}

		/**
		 * @return				history identifier
		 */
		public function get historyName():String
		{
			return this._commandHistory.name;
		}

		/**
		 * @param value			undo history size
		 */
		public function set historySize(value:int):void
		{
			this._commandHistory.size = value;
		}

		/**
		 * @retun				undo history size
		 */
		public function get historySize():int
		{
			return this._commandHistory.size;
		}

		/**
		 * @return				has undoable command in history
		 */
		public function get undoAble():Boolean
		{
			return this._commandHistory.hasPrevious;
		}

		/**
		 * @return 				has redoable command in history
		 */
		public function get redoAble():Boolean
		{
			return this._commandHistory.hasNext;
		}

		/**
		 * Execute command using queue
		 *
		 * @param command			command to be add to the queue
		 */
		public function execute(command:ICommand):void
		{
			this._commandQueue.push(command);
			if (this._commandQueue.hasNext && !this._pendingCommand) this.executeCommand(this._commandQueue.next);
		}

		/**
		 * Undo command in history
		 */
		public function undo():void
		{
			if (this._commandQueue.hasNext) {
				if (LogManager.isDebug()) LogManager.debug(this, "Can't undo command - command in queue");
				return;
			}

			if (this._pendingCommand) {
				if (LogManager.isDebug()) LogManager.debug(this, "Can't undo command - command pending");
				return;
			}

			if (!this._commandHistory.hasPrevious) {
				if (LogManager.isDebug()) LogManager.debug(this, "Can't undo command - nothing to undo");
				return;
			}

			this.undoCommand(this._commandHistory.previous);
		}

		/**
		 * Redo command in history
		 */
		public function redo():void
		{
			if (this._commandQueue.hasNext) {
				if (LogManager.isDebug()) LogManager.debug(this, "Can't redo command - command in queue");
				return;
			}

			if (this._pendingCommand) {
				if (LogManager.isDebug()) LogManager.debug(this, "Can't redo command - command pending");
				return;
			}

			if (!this._commandHistory.hasNext) {
				if (LogManager.isDebug()) LogManager.debug(this, "Can't redo command - nothing to redo");
				return;
			}

			this.redoCommand(this._commandHistory.next);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Execute command
		//-----------------------------------------------------------------------------------------

		/**
		 * @param command			command to be executed
		 */
		private function executeCommand(command:ICommand):void
		{
			this._pendingCommand = Command(command);
			this._pendingCommand.addEventListener(CommandEvent.COMMAND_COMPLETE, this.onExecuteCommand);
			this._pendingCommand.addEventListener(CommandEvent.COMMAND_ERROR, this.commandErrorEventHandler);
			if (LogManager.isDebug()) LogManager.debug(this, 'Executing command :: ' + getQualifiedClassName(this._pendingCommand));
			if (this._pendingCommand.setBusyStatus) this.setBusyStatus();
			if (LogManager.isDebug()) this._time = getTimer();
			command.execute();
		}

		/**
		 * @private
		 * Remove event listners and add to command to history stack
		 */
		private function onExecuteCommand(event:CommandEvent):void
		{
			if (LogManager.isDebug()) LogManager.debug(this, 'Executed command  :: ' + this._pendingCommand.toString() + ' [' + (getTimer() - this._time) + ' ms]');
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_COMPLETE, this.onExecuteCommand);
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_ERROR, this.commandErrorEventHandler);
			if (this._pendingCommand.setBusyStatus) this.removeBusyStatus();
			this._commandHistory.put(ICommand(this._pendingCommand));
			this._pendingCommand = null;
			if (this._commandQueue.hasNext) this.executeCommand(this._commandQueue.next);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Undo command
		//-----------------------------------------------------------------------------------------

		/**
		 * @return void
		 */
		private function undoCommand(command:IUndoableCommand):void
		{
			if (command) {
				this._pendingCommand = Command(command);
				this._pendingCommand.addEventListener(CommandEvent.COMMAND_COMPLETE, this.onUndoCommand);
				this._pendingCommand.addEventListener(CommandEvent.COMMAND_ERROR, this.commandErrorEventHandler);
				if (this._pendingCommand.setBusyStatus) this.setBusyStatus();
				command.undo();
			}
		}

		/**
		 * @return void
		 */
		private function onUndoCommand(event:CommandEvent):void
		{
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_COMPLETE, this.onUndoCommand);
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_ERROR, this.commandErrorEventHandler);
			if (this._pendingCommand.setBusyStatus) this.removeBusyStatus();
			this._pendingCommand = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Redo command
		//-----------------------------------------------------------------------------------------

		/**
		 * @return void
		 */
		private function redoCommand(command:IRedoableCommand):void
		{
			if(command) {
				this._pendingCommand = Command(command);
				this._pendingCommand.addEventListener(CommandEvent.COMMAND_COMPLETE, this.onRedoCommand);
				this._pendingCommand.addEventListener(CommandEvent.COMMAND_ERROR, this.commandErrorEventHandler);
				if (this._pendingCommand.setBusyStatus) this.setBusyStatus();
				command.redo();
			}
		}

		/**
		 * @return void
		 */
		private function onRedoCommand(event:CommandEvent):void
		{
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_COMPLETE, this.onRedoCommand);
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_ERROR, this.commandErrorEventHandler);
			if (this._pendingCommand.setBusyStatus) this.removeBusyStatus();
			this._pendingCommand = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Status management
		//-----------------------------------------------------------------------------------------

		/**
		 * @return void
		 */
		private function setBusyStatus():void
		{
			if (!this._busySet) {
				this._busySet = true;
				StatusManager.setBusyStatus(this);
			}
		}

		/**
		 * @param force True forces the cursor to be removed
		 * @return void
		 */
		private function removeBusyStatus(force:Boolean=false):void
		{
			var nextCmd:Command = Command(this._commandQueue.getCommandAt(0));
			if (force || !nextCmd ||  !nextCmd.setBusyStatus) {
				StatusManager.removeBusyStatus(this);
				this._busySet = false;
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private Eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 * On a command fault everything will be cleared.
		 *
		 * <p>That means that the all commands in the queue will be removed and
		 * all stacks will be cleared.</p>
		 *
		 * @param event
		 * @return void
		 */
		private function commandErrorEventHandler(event:CommandEvent):void
		{
			if (LogManager.isError()) LogManager.error(this, 'Command fault while executing command ' + getQualifiedClassName(this._pendingCommand));
			if (LogManager.isError()) LogManager.error(this, 'Clearing history and queue');
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_COMPLETE, this.onUndoCommand);
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_COMPLETE, this.onRedoCommand);
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_COMPLETE, this.onExecuteCommand);
			this._pendingCommand.removeEventListener(CommandEvent.COMMAND_ERROR, this.commandErrorEventHandler);
			ClassUtil.callMethodIfType(this._pendingCommand, IUnload, 'unload');
			this._pendingCommand = null;
			this._commandHistory.clear();
			this._commandQueue.clear();
			this.removeBusyStatus(true);
			this.dispatchEvent(new CommandEvent(event.type, event.command));
		}
	}
}