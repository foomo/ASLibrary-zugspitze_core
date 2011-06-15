package org.foomo.zugspitze.operations
{
	import flash.events.IEventDispatcher;

	[Event(name="operationError", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationComplete", type="org.foomo.zugspitze.events.OperationEvent")]

	public interface IOperation extends IEventDispatcher
	{
		function get result():*;
		function get error():*;
	}
}