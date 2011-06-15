package org.foomo.zugspitze.managers
{
	import flash.events.IEventDispatcher;

	/**
	 *  @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")]

	internal interface IStatusManager extends IEventDispatcher
	{
		/**
		 * Returns current request stack
		 */
		function get stack():Array;

		/**
		 * Returns the current application status
		 */
		function get busy():Boolean;

		/**
		 * Set busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		function setBusyStatus(instance:Object):void;

		/**
		 * Remove busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		function removeBusyStatus(instance:Object):void;
	}
}