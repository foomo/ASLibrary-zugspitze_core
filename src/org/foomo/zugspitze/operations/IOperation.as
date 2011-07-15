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
package org.foomo.zugspitze.operations
{
	import flash.events.IEventDispatcher;

	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public interface IOperation extends IEventDispatcher
	{
		/**
		 * Returns an untyped result
		 */
		function get untypedResult():*;
		/**
		 * Returns an untyped error
		 */
		function get untypedError():*;
		/**
		 * Returns the operation total
		 */
		function get total():Number;
		/**
		 * Returns the operation progress
		 */
		function get progress():Number;


		function addProgressCallback(callback:Function, ... args):IOperation
		function addProgressListener(listener:Function):IOperation
		function chainOnProgress(operationCall:Function, ... args):IOperation

		function addCompleteCallback(callback:Function, ... args):IOperation
		function addCompleteListener(listener:Function):IOperation
		function chainOnComplete(operationCall:Function, ... args):IOperation

		function addErrorCallback(callback:Function, ... args):IOperation
		function addErrorListener(listener:Function):IOperation
		function chainOnError(operationCall:Function, ... args):IOperation
	}
}