package org.foomo.zugspitze.managers
{
	import org.foomo.zugspitze.commands.ICommand;

	import flash.events.IEventDispatcher;

	/**
	 *  @eventType org.foomo.zugspitze.events.CommandEvent.COMMAND_ERROR
	 */
	[Event(name="commandError", type="org.foomo.zugspitze.events.CommandEvent")]
	/**
	 *  @eventType org.foomo.zugspitze.events.CommandEvent.COMMAND_COMPLETE
	 */
	[Event(name="commandComplete", type="org.foomo.zugspitze.events.CommandEvent")]

	internal interface ICommandManager extends IEventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Singleton initalization
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		function ICommandManager(historyName:String, historySize:Number)

		//-----------------------------------------------------------------------------------------
		// ~ Command History
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value			history identifier
		 */
		function set historyName(value:String):void

		/**
		 * @return				history identifier
		 */
		function get historyName():String

		/**
		 * @param value 		undo history size
		 */
		function set historySize(value:int):void

		/**
		 * @return 				undo history size
		 */
		function get historySize():int

		/**
		 * @return				has undoable command in history
		 */
		function get undoAble():Boolean

		/**
		 * @return 				has redoable command in history
		 */
		function get redoAble():Boolean

		//-----------------------------------------------------------------------------------------
		// ~ Public static mehtods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value 			Execute command through queue
		 */
		function execute(command:ICommand):void

		/**
		 * Undo command in history
		 */
		function undo():void

		/**
		 * Redo command in history
		 */
		function redo():void
	}
}