package org.foomo.zugspitze.operations
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import org.foomo.zugspitze.events.OperationEvent;

	[Event(name="operationError", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationComplete", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationProgress", type="org.foomo.zugspitze.events.OperationEvent")]

	public class Operation extends EventDispatcher implements IOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variabels
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _error:*;
		/**
		 *
		 */
		private var _result:*;
		/**
		 *
		 */
		private var _total:uint;
		/**
		 *
		 */
		private var _progress:uint;
		/**
		 *
		 */
		private var _eventClass:Class;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function Operation(eventClass:Class=null)
		{
			this._eventClass = (eventClass) ? eventClass : OperationEvent;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get operationResult():*
		{
			return this._result;
		}

		/**
		 *
		 */
		public function get operationError():*
		{
			return this._error;
		}

		/**
		 *
		 */
		public function get total():uint
		{
			return this._total;
		}

		/**
		 *
		 */
		public function get progress():uint
		{
			return this._progress;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function dispatchOperationProgressEvent(total:uint, progress:uint):Boolean
		{
			this._total = total;
			this._progress = progress;
			return this.dispatchEvent(new this._eventClass(OperationEvent.OPERATION_PROGRESS, this));
		}

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