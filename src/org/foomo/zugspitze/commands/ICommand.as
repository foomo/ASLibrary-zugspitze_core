package org.foomo.zugspitze.commands
{
	import flash.events.IEventDispatcher;

	/**
	 * Enables a command to be executed
	 */
	public interface ICommand extends IEventDispatcher
	{
		/**
		 * Execute the command
		 */
		function execute():void;
	}
}