package org.foomo.zugspitze.events
{
	import flash.events.Event;

	import org.foomo.zugspitze.operations.IOperation;

	public class OperationEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const OPERATION_COMPLETE:String 	= 'operationComplete';
		public static const OPERATION_PROGRESS:String 	= 'operationProgress';
		public static const OPERATION_ERROR:String 		= 'operationError';

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _operation:IOperation;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function OperationEvent(type:String, operation:IOperation)
		{
			this._operation = operation;
			super(type);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get operation():IOperation
		{
			return this._operation;
		}

		/**
		 *
		 */
		public function get operationResult():*
		{
			return this._operation.operationResult;
		}

		/**
		 *
		 */
		public function get operationError():*
		{
			return this._operation.operationError;
		}

		/**
		 *
		 */
		public function get total():uint
		{
			return this._operation.total;
		}

		/**
		 *
		 */
		public function get progress():uint
		{
			return this._operation.progress;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function clone():Event
		{
			return new OperationEvent(this.type, this.operation);
		}

		/**
		 * @inherit
		 */
		override public function toString():String
		{
			return formatToString('OperationEvent');
		}
	}
}