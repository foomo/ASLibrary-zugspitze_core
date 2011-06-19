package org.foomo.zugspitze.operations
{
	import flash.events.IEventDispatcher;

	public interface IOperation extends IEventDispatcher
	{
		/**
		 * Returns an untyped result
		 */
		function get untypedResult():*;
		/**
		 * Returns an untyped error
		 */
		function get untypedError():*;
		/**
		 * Returns the operation total
		 */
		function get total():Number;
		/**
		 * Returns the operation progress
		 */
		function get progress():Number;
	}
}