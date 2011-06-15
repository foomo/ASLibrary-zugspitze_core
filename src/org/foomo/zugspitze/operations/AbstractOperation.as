package org.foomo.zugspitze.operations
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import org.foomo.zugspitze.events.OperationEvent;

	[Event(name="operationError", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationComplete", type="org.foomo.zugspitze.events.OperationEvent")]

	public class AbstractOperation extends EventDispatcher implements IOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variabels
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected var _error:*;
		/**
		 *
		 */
		protected var _result:*;
		/**
		 *
		 */
		protected var _eventClass:Class;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function AbstractOperation(eventClass:Class=null)
		{
			this._eventClass = (eventClass) ? eventClass : OperationEvent;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():*
		{
			return this._result;
		}

		/**
		 *
		 */
		public function get error():*
		{
			return this._error;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function dispatchOperationCompleteEvent(result:*=null):Boolean
		{
			if (result != null) this._result = result;
			return this.dispatchEvent(new this._eventClass(OperationEvent.OPERATION_COMPLETE, this));
		}

		/**
		 *
		 */
		protected function dispatchOperationErrorEvent(error:*=null):Boolean
		{
			if (error != null) this._error = error;
			return this.dispatchEvent(new this._eventClass(OperationEvent.OPERATION_ERROR, this));
		}
	}
}