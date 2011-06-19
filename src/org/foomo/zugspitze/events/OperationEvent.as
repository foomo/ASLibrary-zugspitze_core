package org.foomo.zugspitze.events
{
	import flash.events.Event;

	import org.foomo.zugspitze.operations.IOperation;
	import org.foomo.zugspitze.utils.ClassUtils;

	/**
	 * This class should not be used by it's own.
	 * Extend it and define your own result and error types
	 */
	public class OperationEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _result:*;
		/**
		 *
		 */
		private var _error:*;
		/**
		 *
		 */
		private var _total:Number;
		/**
		 *
		 */
		private var _progress:Number;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function OperationEvent(type:String, result:*=null, error:*=null, total:Number=0, progress:Number=0)
		{
			this._result = result;
			this._error = error;
			this._total = total;
			this._progress = progress;
			super(type);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get untypedResult():*
		{
			return this._result;
		}

		/**
		 *
		 */
		public function get untypedError():*
		{
			return this._error;
		}

		/**
		 *
		 */
		public function get total():Number
		{
			return this._total;
		}

		/**
		 *
		 */
		public function get progress():Number
		{
			return this._progress;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function clone():Event
		{
			var eventClass:Class = ClassUtils.getClass(this);
			return new eventClass(this.type, this.untypedResult, this.untypedError, this.total, this.progress);
		}

		/**
		 * @inherit
		 */
		override public function toString():String
		{
			return formatToString(ClassUtils.getClassName(this), 'result', 'error', 'total', 'progress');
		}
	}
}