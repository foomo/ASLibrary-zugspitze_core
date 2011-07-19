package org.foomo.zugspitze.operations
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	import org.foomo.core.IUnload;
	import org.foomo.managers.LogManager;
	import org.foomo.utils.ClassUtil;
	import org.foomo.utils.StringUtil;

	use namespace flash_proxy;

	dynamic public class EventDispatcherChain extends Proxy
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _dispatcher:IEventDispatcher;
		private var _pendingEventListeners:Array = [];
		private var _dispatcherEventListeners:Array = [];

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function EventDispatcherChain()
		{
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function addEventCallback(type:String, callback:Function, eventArgs:Array=null, ... rest):EventDispatcherChain
		{
			var fnc:Function
			var instance:EventDispatcherChain = this;
			if (eventArgs == null) eventArgs = [];

			fnc = function(event:Event):void {
				instance.extractArgs(event, callback.length, eventArgs, rest);
				callback.apply(instance, rest);
			}

			return this.addDispatcherEventListener(type, fnc);
		}

		/**
		 *
		 */
		public function addEventListener(type:String, listener:Function):EventDispatcherChain
		{
			return this.addDispatcherEventListener(type, listener);
		}

		/**
		 *
		 */
		public function chainOn(type:String, dispatcher:Class, eventArgs:Array=null, ... rest):EventDispatcherChain
		{
			var fnc:Function;
			var clazz:Class = ClassUtil.getClass(this);
			var instance:EventDispatcherChain = this;
			var newInstance:EventDispatcherChain = new clazz;
			if (eventArgs == null) eventArgs = [];

			fnc = function(event:Event):void {
				newInstance.extractArgs(event, ClassUtil.getConstructorParameters(dispatcher).length, eventArgs, rest);
				newInstance.setDispatcher(dispatcher, rest);
				instance.unload();
			}

			instance.addEventListener(type, fnc);
			return newInstance;
		}

		/**
		 *
		 */
		public function unloadOnEvent(type:String):EventDispatcherChain
		{
			return this.addDispatcherEventListener(type, this.unloadHandler);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		flash_proxy override function callProperty(name:*, ...rest):*
		{
			var type:String;
			var method:String = QName(name).localName;
			switch (true) {
				case (method.substr(0, 3) == 'add' && method.substr(-8) == 'Callback'):
					type = StringUtil.lcFirst(method.substring(3, method.length-8));
					rest.unshift(type);
					return (this.addEventCallback as Function).apply(this, rest);
					break;
				case (method.substr(0, 3) == 'add' && method.substr(-8) == 'Listener'):
					type = StringUtil.lcFirst(method.substring(3, method.length-8));
					rest.unshift(type);
					return (this.addEventListener as Function).apply(this, rest);
					break;
				case (method.substr(0, 7) == 'chainOn'):
					type = StringUtil.lcFirst(method.substring(7));
					rest.unshift(type);
					var x:* = this.chainOn;
					return (this.chainOn as Function).apply(this, rest);
					break;
				case (method.substr(0, 8) == 'unloadOn'):
					type = StringUtil.lcFirst(method.substring(8));
					return (this.unloadOnEvent as Function).apply(this, [type]);
					break;
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private function unloadHandler(event:Event):void
		{
			this.unload();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		flash_proxy function unload():void
		{
			LogManager.debug(this, 'Unloading for {0}', this._dispatcher);
			this.removeAllDispatcherListeners();
			this._pendingEventListeners = null;
			this._dispatcher = null;
		}

		flash_proxy function setDispatcher(dispatcher:Class, args:Array):EventDispatcherChain
		{
			var obj:Object
			this._dispatcher = ClassUtil.createInstance(dispatcher, args);
			while (obj = this._pendingEventListeners.shift()) this.addDispatcherEventListener(obj.type, obj.listener);
			return this;
		}

		flash_proxy function extractArgs(event:Event, methodCount:int, eventArgs:Array, rest:Array):void
		{
			var eventArg:String
			while (eventArg = eventArgs.shift()) {
				var arg:* = event;
				var eventArgItem:*;
				var eventArgItems:Array = eventArg.split('.');
				while (eventArgItem = eventArgItems.shift()) arg = arg[eventArgItem];
				rest.unshift(arg);
			}
		}

		/**
		 *
		 */
		flash_proxy function addDispatcherEventListener(type:String, listener:Function):EventDispatcherChain
		{
			if (this._dispatcher) {
				this._dispatcherEventListeners.push({type:type, listener:listener});
				this._dispatcher.addEventListener(type, listener, false, 0, true);
			} else {
				this._pendingEventListeners.push({type:type, listener:listener});
			}
			return this;
		}

		/**
		 *
		 */
		flash_proxy function removeAllListeners():EventDispatcherChain
		{
			var obj:Object
			while (obj = this._dispatcherEventListeners.shift()) this._dispatcher.removeEventListener(obj.type, obj.listener);
			obj = null;
			return this;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function create(dispatcher:Class, ... rest):EventDispatcherChain
		{
			var ret:EventDispatcherChain = new EventDispatcherChain();
			return ret.setDispatcher(dispatcher, rest);
		}
	}
}