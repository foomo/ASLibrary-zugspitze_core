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
	import flash.events.IEventDispatcher;

	[Event(name="zugspitzeControllerChange", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeModelChange", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeViewChange", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeViewRemove", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeComplete", type="org.foomo.zugspitze.events.ZugspitzeEvent")]
	[Event(name="zugspitzeViewAdd", type="org.foomo.zugspitze.events.ZugspitzeEvent")]

	/**
	 * Interface for zugspitzimplementations
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
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