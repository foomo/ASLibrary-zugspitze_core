package org.foomo.zugspitze.operations
{
	import org.foomo.utils.ClassUtil;
	import org.foomo.zugspitze.events.ProgressOperationEvent;

	public class ProgressOperation extends Operation implements IProgressOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected var _total:Number;
		/**
		 *
		 */
		protected var _progress:Number;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ProgressOperation()
		{
			super();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

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

		/**
		 *
		 */
		public function addProgressListener(listener:Function):IProgressOperation
		{
			this.addEventListener(ProgressOperationEvent.OPERATION_PROGRESS, listener, false, 0, true);
			return this;
		}

		/**
		 *
		 */
		public function addProgressCallback(callback:Function, ... args):IProgressOperation
		{
			return this.addCallback(callback, args);
		}

		/**
		 *
		 */
		public function chainOnProgress(operation:Class, ... args):IProgressOperation
		{
			return null;
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
			return this.dispatchEvent(new ProgressOperationEvent(ProgressOperationEvent.OPERATION_PROGRESS, this));
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private function addCallback(callback:Function, args:Array):IProgressOperation
		{
			var fnc:Function
			var instance:Operation = this;

			fnc = function(event:ProgressOperationEvent):void {
				if (callback.length > args.length) args.unshift(event.operation.total);
				if (callback.length > args.length) args.unshift(event.operation.progress);
				callback.apply(instance, args);
				instance.removeEventListener(ProgressOperationEvent.OPERATION_PROGRESS, fnc);
			}
			instance.addEventListener(ProgressOperationEvent.OPERATION_PROGRESS, fnc, false, 0, true);
			return this;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function create(operation:Class, ... args):IProgressOperation
		{
			return ClassUtil.createInstance(operation, args);
		}
	}
}