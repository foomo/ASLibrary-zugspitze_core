package org.foomo.zugspitze.operations
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	import org.foomo.zugspitze.core.IUnload;

	public class LoadURLOperation extends AbstractProgressOperation implements IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		protected var _loader:URLLoader;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function LoadURLOperation(url:String, dataFormat:String=null)
		{
			super();

			this._loader = new URLLoader();
			this._loader.dataFormat = (dataFormat == null) ? URLLoaderDataFormat.TEXT : dataFormat;
			this._loader.addEventListener(Event.COMPLETE, this.loader_completeHandler);
			this._loader.addEventListener(ProgressEvent.PROGRESS, this.loader_progressHandler);
			this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loader_errorHandler);
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.loader_errorHandler);
			this._loader.load(new URLRequest(url));
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function unload():void
		{
			if (!this._loader) return;
			this._loader.removeEventListener(Event.COMPLETE, this.loader_completeHandler);
			this._loader.removeEventListener(ProgressEvent.PROGRESS, this.loader_progressHandler);
			this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loader_errorHandler);
			this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.loader_errorHandler);
			this._loader = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		protected function loader_progressHandler(event:ProgressEvent):void
		{
			this.dispatchOperationProgressEvent(event.bytesTotal, event.bytesLoaded);
		}

		protected function loader_completeHandler(event:Event):void
		{
			this.dispatchOperationCompleteEvent(this._loader.data);
		}

		protected function loader_errorHandler(event:Event):void
		{
			this.dispatchOperationErrorEvent(event['text']);
		}
	}
}