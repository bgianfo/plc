/**
 * Author: Brian Gianforcaro (bjg1955@cs.rit.edu)
 * PLC Lab #3: JavaScript
 */

DEBUG = true;

/**
 * Turn off logging statements if they become annoying.
 */
if ( !DEBUG ) { console.log = function(){}; }


/**
 * Arith class constructor
 */
function Arith() {

  /**
   * Duplicate the top value on the stack.
   */
  Arith.prototype.enter = function() {
    this.stack.push( this.stack[this.stack.length-1] );
  }

  /**
   * Return the value stored in the top of the stack, or 0 if the stack is empty.
   * The stack is unchanged.
   *
   * @return The top of the stack, or zero.
   */
  Arith.prototype.getStackTop = function() {
    return this.stack[this.stack.length-1];
  }

  /**
   * Set the value of the top of the stack to value.
   * The stack size is unchanged.
   *
   * @param value - The value to set the top of the stack to
   */
  Arith.prototype.setStackTop = function( value ) {
     console.log( "setstack: " + value );
     this.stack[this.stack.length-1] = value;
  }

  /**
   * Addition operator callback
   */
  Arith.prototype.addition = function() {
    console.log("calling addition")
    first = parseInt( this.stack.pop() );
    second = parseInt( this.stack.pop() );
    this.setStackTop( first + second );
  }

  /**
   * Subtraction operator callback
   */
  Arith.prototype.subtraction = function() {
    console.log("calling subtraction")
    first = this.stack.pop();
    second = this.stack.pop();
    this.setStackTop( first - second );
  }

  /**
   * Multiplication operator callback
   */
  Arith.prototype.multiplication = function() {
    console.log("calling multiplication")
    first = this.stack.pop();
    second = this.stack.pop();
    this.setStackTop( first * second );
  }

  /**
   * Division operator callback
   */
  Arith.prototype.division = function() {
    console.log("calling division")
    divisor = this.stack.pop();
    dividend = this.stack.pop();
    quotient = dividend/divisor;
    this.setStackTop( quotient );
  }

  /* An array of numbers recently entered by the user or computed. */
  Arith.prototype.stack = new Array();
  Arith.prototype.stack[0] = 0;

  /**
   * An array of up to four symbols for the operations.
   * The symbols should match the names of the properties in opList.
   */
  this.opNames = {
    "+":"addition",
    "-":"subtraction",
    "*":"multiplication",
    "/":"division"
  };

  /**
   * An object that maps the string names of the calculator's
   * operation buttons to the operation methods above by use
   * of its property names and values.
   */
  this.opList = {
    "addition": Arith.prototype.addition,
    "subtraction": Arith.prototype.subtraction,
    "multiplication": Arith.prototype.multiplication,
    "division": Arith.prototype.division
  };
}
