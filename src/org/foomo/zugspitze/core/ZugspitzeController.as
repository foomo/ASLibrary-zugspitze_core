package org.foomo.zugspitze.core
{
	import org.foomo.zugspitze.commands.Command;
	import org.foomo.zugspitze.commands.ICommand;
	import org.foomo.zugspitze.managers.CommandManager;

	import flash.events.EventDispatcher;
	import org.foomo.zugspitze.zugspitze_internal;

	/**
	 * Zugspitze Controller.
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