package org.foomo.zugspitze.events
{
	import flash.events.Event;

	public class ZugspitzeEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const ZUGSPITZE_CONTROLLER_CHANGED:String 	= 'zugspitzeControllerChanged';
		public static const ZUGSPITZE_MODEL_CHANGED:String 			= 'zugspitzeModelChanged';
		public static const ZUGSPITZE_VIEW_CHANGED:String 			= 'zugspitzeViewChanged';
		public static const ZUGSPITZE_VIEW_REMOVE:String 			= 'zugspitzeViewRemove';
		public static const ZUGSPITZE_VIEW_ADD:String 				= 'zugspitzeViewAdd';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ZugspitzeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function clone():Event
		{
			return new ZugspitzeEvent(this.type, this.bubbles, this.cancelable);
		}
	}
}