package org.foomo.zugspitze.managers
{
	import org.foomo.zugspitze.core.Singleton;

	import flash.events.EventDispatcher;

	/**
	 *  @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")]

	public class StatusManager extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 *  Linker dependency on implementation class.
		 */
		private static var _implClassDependency:StatusManagerImpl

		/**
		 * @private
		 */
		private static var _impl:IStatusManager;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton instance
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static function get impl():IStatusManager
		{
			if (!_impl) _impl = IStatusManager(Singleton.getInstance("org.foomo.zugspitze.managers::IStatusManager"));
			return _impl;
		}

		/**
		 * @return ICommandManager
		 */
		public static function getInstance():IStatusManager
		{
			return impl;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Returns current request stack
		 */
		public static function get stack():Array
		{
			return impl.stack;
		}

		/**
		 * Set busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		public static function setBusyStatus(instance:Object):void
		{
			impl.setBusyStatus(instance);
		}

		/**
		 * Remove busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		public static function removeBusyStatus(instance:Object):void
		{
			impl.removeBusyStatus(instance);
		}

		/**
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakRefernce
		 */
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=true):void
		{
			impl.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * @param type
		 * @param listener
		 */
		public static function removeEventListener(type:String, listener:Function):void
		{
			impl.removeEventListener(type, listener);
		}
	}
}