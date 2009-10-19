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

}

/**
 * An object that maps the string names of the calculator's 
 * operation buttons to the operation methods above by use
 * of its property names and values. 
 */
Arith.opList = {
                 "addition":addition(), 
                 "subtraction":subtraction(),
                 "multiplicaiton":multiplication(),
                 "division":division() 
               };

/** 
 * An array of up to four symbols for the operations. 
 * The symbols should match the names of the properties in opList.
 */
Arith.opNames = { 
                  "+":"addition", 
                  "-":"subtraction",
                  "*":"multiplicaiton",
                  "/":"division"
                };

/**
 * Duplicate the top value on the stack.
 */
Arith.prototype.enter = function() 
{
    this.stack.push(this.stack.top());
}

/**
 * Return the value stored in the top of the stack, or 0 if the stack is empty.
 * The stack is unchanged.
 *
 * @return The top of the stack, or zero.
 */
Arith.prototype.getStackTop = function() 
{
    return (this.stack.top() === undefined) ? 0 : this.stack.top();
}

/**
 * Set the value of the top of the stack to value. 
 * The stack size is unchanged.
 *
 * @param v - The value to set the top of the stack to
 */
Arith.prototype.setStackTop = function( value ) 
{
   this.stack[0] = value; 
}


function ophelper( op ) {
    op.call(Arith);
}

function addition() {
}

function subtraction() {
}

function multiplication() {
}

function division() {
}

