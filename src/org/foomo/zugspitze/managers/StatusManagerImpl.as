package org.foomo.zugspitze.managers
{
	import org.foomo.zugspitze.utils.ArrayUtils;
	import org.foomo.zugspitze.utils.ClassUtils;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	/**
	 *  @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")]

	//[ExcludeClass]
	public class StatusManagerImpl extends EventDispatcher implements IStatusManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private static var _instance:StatusManagerImpl;

		/**
		 * @private
		 * Flag if busy cursor is in use
		 */
		private var _busy:Boolean = false;
		/**
		 * @private
		 * Holds all current caller by dictionary
		 */
		private var _stack:Array = new Array;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		public function StatusManagerImpl()
		{
		}

		/**
		 * @private
		 */
		public static function getInstance():StatusManagerImpl
		{
			if (!_instance) _instance = new StatusManagerImpl();
			return _instance;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Returns current request stacking status
		 */
		public function get stack():Array
		{
			return this._stack;
		}

		/**
		 * Tells whether the busy cursor is visible or not
		 *
		 * <p>You may want to bind this property to disable the view in that time<br>
		 * Usage: SatusManager.busy</p>
		 *
		 * @return 				whether the busy cursor is in use or not
		 */
		[Bindable(event="change")]
		public function get busy():Boolean
		{
			return this._busy;
		}

		/**
		 * Set busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		public function setBusyStatus(instance:Object):void
		{
			this._stack.push(ClassUtils.getQualifiedName(instance));
			if (this._busy) return;
			this._busy = true;
			this.dispatchEvent(new Event(Event.CHANGE));
		}

		/**
		 * Remove busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		public function removeBusyStatus(instance:Object):void
		{
			if (this._stack.length == 0) return;

			var aliasName:String 	= ClassUtils.getQualifiedName(instance);
			var itemIndex:int 		= ArrayUtils.getItemIndex(aliasName, this._stack);

			if (itemIndex < 0) {
				if (LogManager.isError()) LogManager.error(this, 'Instance not found in stack');
			} else {
				this._stack.splice(itemIndex, 1);
				if (this._stack.length == 0) {
					this._busy = false;
					this.dispatchEvent(new Event(Event.CHANGE));
				}
			}
		}
	}
}