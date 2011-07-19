package org.foomo.zugspitze.operations
{
	import flash.utils.flash_proxy;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.events.ProgressOperationEvent;

	use namespace flash_proxy;

	dynamic public class OperationChain extends EventDispatcherChain
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function addOperationErrorListener(listener:Function):OperationChain
		{
			return super.addEventListener(OperationEvent.OPERATION_COMPLETE, listener) as OperationChain;
		}

		public function addOperationCompleteListener(listener:Function):OperationChain
		{
			return super.addEventListener(OperationEvent.OPERATION_COMPLETE, listener) as OperationChain;
		}

		public function addOperationProgressListener(listener:Function):OperationChain
		{
			return super.addEventListener(ProgressOperationEvent.OPERATION_PROGRESS, listener) as OperationChain;
		}

		public function addOperationCompleteCallback(callback:Function, eventArgs:Array=null, ... rest):OperationChain
		{
			rest.unshift(OperationEvent.OPERATION_COMPLETE, callback, eventArgs);
			return (super.addEventCallback as Function).apply(this, rest);
		}

		public function addOperationErrorCallback(callback:Function, eventArgs:Array=null, ... rest):OperationChain
		{
			rest.unshift(OperationEvent.OPERATION_ERROR, callback, eventArgs);
			return (super.addEventCallback as Function).apply(this, rest);
		}

		public function addOperationProgressCallback(callback:Function, eventArgs:Array=null, ... rest):OperationChain
		{
			rest.unshift(ProgressOperationEvent.OPERATION_PROGRESS, callback, eventArgs);
			return (super.addEventCallback as Function).apply(this, rest);
		}

		public function unloadOnOperationComplete():OperationChain
		{
			return super.unloadOnEvent(OperationEvent.OPERATION_COMPLETE) as OperationChain;
		}

		public function unloadOnOperationError():OperationChain
		{
			return super.unloadOnEvent(OperationEvent.OPERATION_COMPLETE) as OperationChain;
		}

		public function unloadOnOperationProgress():OperationChain
		{
			return super.unloadOnEvent(ProgressOperationEvent.OPERATION_PROGRESS) as OperationChain;
		}

		public function chainOnOperationComplete(dispatcher:Class, eventArgs:Array=null, ... rest):OperationChain
		{
			rest.unshift(OperationEvent.OPERATION_COMPLETE, dispatcher, eventArgs);
			return (super.chainOn as Function).apply(this, rest);
		}

		public function chainOnOperationError(dispatcher:Class, eventArgs:Array=null, ... rest):OperationChain
		{
			rest.unshift(OperationEvent.OPERATION_ERROR, dispatcher, eventArgs);
			return (super.chainOn as Function).apply(this, rest);
		}

		public function chainOnOperationProgress(dispatcher:Class, eventArgs:Array=null, ... rest):OperationChain
		{
			rest.unshift(ProgressOperationEvent.OPERATION_PROGRESS, dispatcher, eventArgs);
			return (super.chainOn as Function).apply(this, rest);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function create(dispatcher:Class, ... rest):OperationChain
		{
			var ret:OperationChain = new OperationChain();
			return ret.setDispatcher(dispatcher, rest) as OperationChain;
		}
	}
}