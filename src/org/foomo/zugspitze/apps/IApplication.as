package org.foomo.zugspitze.apps
{
	import org.foomo.zugspitze.core.ZugspitzeController;
	import org.foomo.zugspitze.core.ZugspitzeModel;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;

	[Event(name="zugspitzeControllerChanged", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeModelChanged", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeViewChanged", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeViewRemove", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeViewAdd", type="org.foomo.zugspitze.events.ZugspitzeEvent")]

	/**
	 * Interface for zugspitzimplementations
	 */
	public interface IApplication extends IEventDispatcher
	{
		/**
		 * Define Controller Class
		 */
		function set controllerClass(value:Class):void;
		/**
		 * Define Model Class
		 */
		function set modelClass(value:Class):void;
		/**
		 * Define View Class
		 */
		function set viewClass(value:Class):void;
		/**
		 * Set Controller instance
		 */
		function set controller(value:ZugspitzeController):void;
		/**
		 * Set Model instance
		 */
		function set model(value:ZugspitzeModel):void;
		/**
		 * Set View instance
		 */
		function set view(value:DisplayObject):void;
		/**
		 * Returns Implementation instance
		 */
		function get application():IApplication;
		/**
		 * Returns Controller instance
		 */
		function get controller():ZugspitzeController;
		/**
		 * Returns Model instance
		 */
		function get model():ZugspitzeModel;
		/**
		 * Returns View instance
		 */
		function get view():DisplayObject;
	}
}