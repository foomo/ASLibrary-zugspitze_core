package org.foomo.zugspitze.operations
{
	import flash.events.EventDispatcher;

	import org.foomo.zugspitze.utils.ClassUtils;
	import org.foomo.zugspitze.utils.StringUtils;

	/**
	 * This class should not be used by it self.
	 * Extend it and define your events and typed result/error.
	 */
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
		private var _total:Number;
		/**
		 *
		 */
		private var _progress:Number;
		/**
		 *
		 */
		private var _eventClass:Class;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function Operation(eventClass:Class)
		{
			this._eventClass = eventClass;
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
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function dispatchOperationProgressEvent(total:Number, progress:Number):Boolean
		{
			this._total = total;
			this._progress = progress;
			return this.dispatchEvent(new this._eventClass(this.eventClassToEventName() + 'Progress', this.untypedResult, this.untypedError, this.total, this.progress));
		}

		/**
		 *
		 */
		protected function dispatchOperationCompleteEvent(result:*=null):Boolean
		{
			if (result != null) this._result = result;
			return this.dispatchEvent(new this._eventClass(this.eventClassToEventName() + 'Complete', this.untypedResult, this.untypedError, this.total, this.progress));
		}

		/**
		 *
		 */
		protected function dispatchOperationErrorEvent(error:*=null):Boolean
		{
			if (error != null) this._error = error;
			return this.dispatchEvent(new this._eventClass(this.eventClassToEventName() + 'Error', this.untypedResult, this.untypedError, this.total, this.progress));
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private function eventClassToEventName():String
		{
			return StringUtils.lcFirst(ClassUtils.getClassName(this._eventClass)).replace('Event', '');
		}
	}
}