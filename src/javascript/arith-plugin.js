/**
 * Author: Brian Gianforcaro bjg1955@cs.rit.edu
 * PLC Lab #3: JavaScript
 */


DEBUG = true;

/**
 * Turn off logging statements if they become annoying.
 */
if (!DEBUG) {
  console.log = function() {};
}

/**
 * Arith class constructor
 */
function Arith() 
{
    /* An array of numbers recently entered by the user or computed. */
    this.stack = Array();
    this.stack[0] = 0;

    this.opNames = {};
    this.opList = {};

    /**
     * Duplicate the top value on the stack.
     */
    this.enter = function() {
      this.stack.push( this.stack.top() );
    }

    /**
     * Return the value stored in the top of the stack, or 0 if the stack is empty.
     * The stack is unchanged.
     *
     * @return The top of the stack, or zero.
     */
    this.getStackTop = function() 
    {
      return (this.stack.top() === undefined) ? 0 : this.stack.top();
    }

    /**
     * Set the value of the top of the stack to value. 
     * The stack size is unchanged.
     *
     * @param v - The value to set the top of the stack to
     */
    this.setStackTop = function( value ) 
    {
       this.stack[0] = value; 
    }
}

