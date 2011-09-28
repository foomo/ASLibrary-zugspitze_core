/*
 * This file is part of the foomo Opensource Framework.
 *
 * The foomo Opensource Framework is free software: you can redistribute it
 * and/or modify it under the terms of the GNU Lesser General Public License as
 * published  by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * The foomo Opensource Framework is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with
 * the foomo Opensource Framework. If not, see <http://www.gnu.org/licenses/>.
 */
package org.foomo.zugspitze.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	import org.foomo.core.Managers;
	import org.foomo.managers.LogManager;
	import org.foomo.managers.LogManagerImpl;
	import org.foomo.utils.CallLaterUtil;
	import org.foomo.utils.ClassUtil;
	import org.foomo.utils.DisplayObjectContainerUtil;
	import org.foomo.zugspitze.events.ZugspitzeEvent;
	import org.foomo.zugspitze.managers.CommandManagerImpl;
	import org.foomo.zugspitze.managers.StatusManagerImpl;
	import org.foomo.zugspitze.zugspitze_internal;

	use namespace zugspitze_internal;

	[Event(name="zugspitzeControllerChange", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeModelChange", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeViewChange", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeComplete", type="org.foomo.zugspitze.events.ZugspitzeEvent")]

	/**
	 * Heart of the MCV framework
	 *
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	final public class Zugspitze extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		private static const ZUGSPITZE_INFO:Object = new Object
		{
			if (LogManager.isInfo()) trace('\n      ../\\\n   ../    |     ZUGSPITZE ' + Zugspitze.VERSION + '\n  /        \\    www.foomo.org/zugspitze\n\n');
		}

		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const VERSION:String = '0.2.0-alpha';

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
			CallLaterUtil.addCallback(this.application_updateHandler);
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
			CallLaterUtil.addCallback(this.application_updateHandler);
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
			this.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_CONTROLLER_CHANGE));
			this.invalidateProperties();
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
			this.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_MODEL_CHANGE));
			this.invalidateProperties();
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
				DisplayObjectContainerUtil.removeChild(this._view, DisplayObjectContainer(this._application));
				this._view.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_VIEW_REMOVE));
			}
			this._view = value;
			if (this._view) {
				if (!this._view.hasOwnProperty('application')) throw new Error('Zugspitze view "' + getQualifiedClassName(this._view) + '" does not contain application var!')
				this._view['application'] = this._application;
				DisplayObjectContainerUtil.addChild(this._view, DisplayObjectContainer(this._application));
				this._view.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_VIEW_ADD));
			}
			this.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_VIEW_CHANGE));
			this.invalidateProperties();
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
		zugspitze_internal function commitProperties():void
		{
			if (this._modelClassChanged) {
				if (!this.model || ClassUtil.getClass(this.model) != this._modelClass) this.model = new this._modelClass;
				this._modelClassChanged = false;
			}

			if (this._controllerClassChanged) {
				if (!this.controller || ClassUtil.getClass(this.controller) != this._controllerClass) this.controller = new this._controllerClass;
				this._controllerClassChanged = false;
			}

			if (this._viewClassChanged) {
				if (!this.view || ClassUtil.getClass(this.view) != this._viewClass) this.view = new this._viewClass;
				this._viewClassChanged = false;
			}

			if (!this._complete && this.controller && this.view && this.model) {
				this.dispatchEvent(new ZugspitzeEvent(ZugspitzeEvent.ZUGSPITZE_COMPLETE));
				this._complete = true;
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private function application_updateHandler():void
		{
			if (this._invalidProperties) {
				this.commitProperties();
				this._invalidProperties = false;
			}
		}
	}
}
