package org.foomo.zugspitze.operations
{
	import flash.events.IEventDispatcher;

	public interface IOperation extends IEventDispatcher
	{
		/**
		 * Returns an untyped result
		 */
		function get operationResult():*;
		/**
		 * Returns an untyped error
		 */
		function get operationError():*;
		/**
		 * Returns the operation total
		 */
		function get total():uint;
		/**
		 * Returns the operation progress
		 */
		function get progress():uint;
	}
}