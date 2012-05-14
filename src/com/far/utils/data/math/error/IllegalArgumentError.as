/*
  GRANITE DATA SERVICES
  Copyright (C) 2007-2010 ADEQUATE SYSTEMS SARL

  This file is part of Granite Data Services.

  Granite Data Services is free software; you can redistribute it and/or modify
  it under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version.

  Granite Data Services is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, see <http://www.gnu.org/licenses/>.
*/

package  com.far.utils.data.math.error{

    /**
	 * This error is thrown whenever a big number function parameter is
	 * called with an invalid parameter.
	 * 
     * @author Franck WOLFF
     */
	public class IllegalArgumentError extends BigNumberError {

		/**
		 * Constructs a new <code>IllegalArgumentError</code>
		 * 
		 * @param message the message of this error.
		 * @param id the numeric code of this error.
		 */
		function IllegalArgumentError(message:* = "", id:* = 0) {
			super(message, id);
		}
	}
}