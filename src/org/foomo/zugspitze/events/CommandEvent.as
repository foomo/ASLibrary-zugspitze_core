package org.foomo.zugspitze.events
{
	import flash.events.Event;

	import org.foomo.zugspitze.commands.ICommand;

	/**
	 * The CommandEvent is dispatched whenever a command is complete or a fault occured.
	 */
	public class CommandEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const COMMAND_COMPLETE:String = 'commandComplete';
		public static const COMMAND_ERROR:String 	= 'commandError';

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * The dispatching command
		 */
		public var command:ICommand;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 * Constructor
		 */
		public function CommandEvent(type:String, command:ICommand, bubbles:Boolean=false, cancleable:Boolean=false)
		{
			this.command = command;
			super(type, bubbles, cancleable);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function clone():Event
		{
			return new CommandEvent(this.type, this.command, this.bubbles, this.cancelable);
		}
	}
}