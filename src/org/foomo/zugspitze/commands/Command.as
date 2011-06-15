package org.foomo.zugspitze.commands
{
	import flash.events.EventDispatcher;

	import org.foomo.zugspitze.core.ISetBusyStatus;
	import org.foomo.zugspitze.events.CommandEvent;

	/**
	 *  @eventType org.foomo.zugspitze.events.CommandEvent.COMMAND_ERROR
	 */
	[Event(name="commandError", type="org.foomo.zugspitze.events.CommandEvent")]
	/**
	 *  @eventType org.foomo.zugspitze.events.CommandEvent.COMMAND_COMPLETE
	 */
	[Event(name="commandComplete", type="org.foomo.zugspitze.events.CommandEvent")]

	/**
	 * Default command class to be extended
	 *
	 * <p>Please keep in mind that the command may still exist after execution due to history
	 * support or garbage collection. So cleen up all referenzes (i.e. EventListeners) to prevent
	 * memory leaks and weired behaviors.</p>
	 */
	public class Command extends EventDispatcher implements ISetBusyStatus
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variabels
		//-----------------------------------------------------------------------------------------

		/**
		 * Indicates to use busy cursor while executed
		 */
		private var _setBusyStatus:Boolean;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function Command(setBusyStatus:Boolean=false)
		{
			this.setBusyStatus = setBusyStatus;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function set setBusyStatus(value:Boolean):void
		{
			this._setBusyStatus = value;
		}
		public function get setBusyStatus():Boolean
		{
			return this._setBusyStatus;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function toString():String
		{
			return super.toString().substring(8, super.toString().length-1);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Dispatch event if complete
		 */
		protected function dispatchCommandCompleteEvent():Boolean
		{
			return this.dispatchEvent(new CommandEvent(CommandEvent.COMMAND_COMPLETE, ICommand(this)));
		}

		/**
		 * Dispatch event if errors occured
		 */
		protected function dispatchCommandErrorEvent(message:String=null):Boolean
		{
			return this.dispatchEvent(new CommandEvent(CommandEvent.COMMAND_ERROR, ICommand(this)));
		}
	}
}