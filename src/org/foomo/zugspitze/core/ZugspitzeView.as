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
	import org.foomo.zugspitze.apps.IApplication;
	import org.foomo.zugspitze.events.ZugspitzeEvent;
	import org.foomo.zugspitze.utils.DisplayObjectUtils;

	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * Zugspitze View Helper.
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class ZugspitzeView
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Returns the view's corresponding zugspitze application implementation.
		 *
		 * <p>As there is no such thing as _lockroot and its corresponding _root,
		 * this is the workaround to get from any composit view to its base.<p>
		 *
		 * @private
		 */
		public static function getApplication(viewComposite:DisplayObject):IApplication
		{
			return DisplayObjectUtils.getParentByClass(viewComposite, IApplication) as IApplication;
		}

		/**
		 * @private
		 */
		public static function init(viewComposite:DisplayObject):IApplication
		{
			var application:IApplication;

			var modelChangedHandler:Function = function(event:ZugspitzeEvent):void {
				viewComposite['model'] = application.model;
			}

			var zugspitzeControllerChangedHandler:Function = function(event:ZugspitzeEvent):void {
				viewComposite['controller'] = application.controller;
			}

			var zugspitzeViewChangedHandler:Function = function(event:ZugspitzeEvent):void {
				var app:IApplication = getApplication(viewComposite);
				if (app && app != application) throw new Error('Wow, you just found a usecase I did not expect!');
				if (app) return;
				// unset all values
				viewComposite['view'] = null;
				viewComposite['model'] = null;
				viewComposite['controller'] = null;
				viewComposite['application'] = null;
				application.removeEventListener(ZugspitzeEvent.ZUGSPITZE_VIEW_CHANGED,  zugspitzeViewChangedHandler);
				application.removeEventListener(ZugspitzeEvent.ZUGSPITZE_MODEL_CHANGED,  modelChangedHandler);
				application.removeEventListener(ZugspitzeEvent.ZUGSPITZE_CONTROLLER_CHANGED,  zugspitzeControllerChangedHandler);
				application = null;
			}

			var zugspitzeViewAddHandler:Function = function(event:ZugspitzeEvent):void {
				if (!viewComposite['application']) throw new Error('Application should have been set by Zugspitze');
				application = viewComposite['application'];
				viewComposite['view'] = application.view;
				viewComposite['model'] = application.model;
				viewComposite['controller'] = application.controller;
				application.addEventListener(ZugspitzeEvent.ZUGSPITZE_MODEL_CHANGED,  modelChangedHandler, false, 0, true);
				application.addEventListener(ZugspitzeEvent.ZUGSPITZE_CONTROLLER_CHANGED,  zugspitzeControllerChangedHandler, false, 0, true);
			}

			var zugspitzeViewRemoveHandler:Function = function(event:ZugspitzeEvent):void {
				application.removeEventListener(ZugspitzeEvent.ZUGSPITZE_MODEL_CHANGED,  modelChangedHandler);
				application.removeEventListener(ZugspitzeEvent.ZUGSPITZE_CONTROLLER_CHANGED,  zugspitzeControllerChangedHandler);
				// unset all values
				viewComposite['view'] = null;
				viewComposite['model'] = null;
				viewComposite['controller'] = null;
				viewComposite['application'] = null;
				application = null;
			}

			var addedToStageHandler:Function = function(event:Event):void {
				if (viewComposite['application']) return;

				application = getApplication(viewComposite);
				if (application) {
					viewComposite['application'] = application;
					viewComposite['view'] = application.view;
					viewComposite['model'] = application.model;
					viewComposite['controller'] = application.controller;
					application.addEventListener(ZugspitzeEvent.ZUGSPITZE_VIEW_CHANGED, zugspitzeViewChangedHandler, false, 0, true);
					application.addEventListener(ZugspitzeEvent.ZUGSPITZE_MODEL_CHANGED,  modelChangedHandler, false, 0, true);
					application.addEventListener(ZugspitzeEvent.ZUGSPITZE_CONTROLLER_CHANGED,  zugspitzeControllerChangedHandler, false, 0, true);
				}
			}

			viewComposite.addEventListener(ZugspitzeEvent.ZUGSPITZE_VIEW_ADD, zugspitzeViewAddHandler, false, Number.MAX_VALUE);
			viewComposite.addEventListener(ZugspitzeEvent.ZUGSPITZE_VIEW_REMOVE, zugspitzeViewRemoveHandler, false, Number.MAX_VALUE);
			viewComposite.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, Number.MAX_VALUE);

			return application;
		}
	}
}