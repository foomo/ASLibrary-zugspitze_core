package org.foomo.zugspitze.commands
{
	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.utils.ClassUtils;

	/**
	 * @private
	 * A simple command queue where commands can be added or taken from
	 */
	//[ExcludeClass]
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