package org.foomo.zugspitze.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	import org.foomo.zugspitze.apps.IApplication;
	import org.foomo.zugspitze.events.ZugspitzeEvent;
	import org.foomo.zugspitze.managers.CommandManagerImpl;
	import org.foomo.zugspitze.managers.LogManagerImpl;
	import org.foomo.zugspitze.managers.StatusManagerImpl;
	import org.foomo.zugspitze.utils.DisplayObjectContainerUtils;
	import org.foomo.zugspitze.zugspitze_internal;

	use namespace zugspitze_internal;

	[Event(name="zugspitzeControllerChanged", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeModelChanged", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeViewChanged", type="org.foomo.zugspitze.events.ZugspitzeEvent")]

	/**
	 * Heart of the MCV framework
	 */
	final public class Zugspitze extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const VERSION:String = 'Beta';

		// TODO: Find a good place to initalize this
		Singleton.registerClass('org.foomo.zugspitze.managers::ICommandManager', CommandManagerImpl);
		Singleton.registerClass('org.foomo.zugspitze.managers::IStatusManager', StatusManagerImpl);
		Singleton.registerClass('org.foomo.zugspitze.managers::ILogManager', LogManagerImpl);

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 * Application instance
		 */
		private var _application:IApplication;
		/**
		 * @private
		 * Controller class to be initialized
		 */
		private var _controllerClass:Class;
		private var _controllerClassChanged:Boolean = false;
		/**
		 * @private
		 * Model class to be initialized
		 */
		private var _modelClass:Class;
		private var _modelClassChanged:Boolean = false;
		/**
		 * @private
		 * View class to be initialized
		 */
		private var _viewClass:Class;
		private var _viewClassChanged:Boolean = false;
		/**
		 * Controller instance
		 */
		private var _controller:ZugspitzeController;
		/**
		 * Model instance
		 */
		private var _model:ZugspitzeModel;
		/**
		 * View instance
		 */
		private var _view:DisplayObject;
		/**
		 * @private
		 */
		private var _invalidProperties:Boolean = true;
		/**
		 * @private
		 */
		private var _initialized:Boolean = false;
		/**
		 * @private
		 */
		private var _complete:Boolean = false;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function Zugspitze(application:IApplication)
		{
			this._application = application;
			DisplayObject(this._application).addEventListener(Event.ENTER_FRAME, this.application_enterFrameHandler, false, 0, true);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function invalidateProperties():void
		{
			this._invalidProperties = true;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public Getter and Setter
		//-----------------------------------------------------------------------------------------

		/**
		 * @return Boolean
		 */
		public function get initialized():Boolean
		{
			return this._initialized;
		}

		/**
		 * Zugspitze application implementation class
		 */
		public function get application():IApplication
		{
			return this._application;
		}

		/**
		 * Controller class that will be used for initialization
		 */
		public function set controllerClass(value:Class):void
		{
			if (this._controllerClass == value) return;
			this._controllerClass = value;
			this._controllerClassChanged = true;
			this.invalidateProperties();
		}

		/**
		 * Model class that will be used for initialization
		 */
		public function set modelClass(value:Class):void
		{
			if (this._controllerClass == value) return;
			this._modelClass = value;
			this._modelClassChanged = true;
			this.invalidateProperties();
		}

		/**
		 * View class that will be used for initialization
		 */
		public function set viewClass(value:Class):void
		{
			if (this._controllerClass == value) return;
			this._viewClass = value;
			this._viewClassChanged = true;
			this.invalidateProperties();
		}

		/**
		 * The zugspitze controller instance
		 */
		public function set controller(value:ZugspitzeController):void
		{
			if (this._controller == value) return;
			if (this._controller) this._controller.zugspitze = null;
			this._controller = value;
			if (this._controller) this._controller.zugspitze = this;
			this.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_CONTROLLER_CHANGED));
		}
		public function get controller():ZugspitzeController
		{
			return this._controller;
		}

		/**
		 * The zugspitze model instance
		 */
		public function set model(value:ZugspitzeModel):void
		{
			if (this._model == value) return;
			this._model = value;
			this.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_MODEL_CHANGED));
		}
		public function get model():ZugspitzeModel
		{
			return this._model;
		}

		/**
		 * The zugspitze view instance
		 */
		public function set view(value:DisplayObject):void
		{
			if (this._view == value) return
			if (this._view) {
				DisplayObjectContainerUtils.removeChild(this._view, DisplayObjectContainer(this._application));
				this._view.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_VIEW_REMOVE));
			}
			this._view = value;
			if (this._view) {
				if (!this._view.hasOwnProperty('application')) throw new Error('Zugspitze view "' + getQualifiedClassName(this._view) + '" does not contain application var!')
				this._view['application'] = this._application;
				DisplayObjectContainerUtils.addChild(this._view, DisplayObjectContainer(this._application));
				this._view.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_VIEW_ADD));
			}
			this.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_VIEW_CHANGED));
		}
		public function get view():DisplayObject
		{
			return this._view;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function commitProperties():void
		{
			if (this._modelClassChanged) {
				this.model = new this._modelClass;
				this._modelClassChanged = false;
			}

			if (this._controllerClassChanged) {
				this.controller = new this._controllerClass;
				this._controllerClassChanged = false;
			}

			if (this._viewClassChanged) {
				this.view = new this._viewClass;
				this._viewClassChanged = false;
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private function application_enterFrameHandler(event:Event):void
		{
			if (this._invalidProperties) {
				this.commitProperties();
				this._invalidProperties = false;
			}
		}
	}
}