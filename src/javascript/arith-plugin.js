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
function Arith() {
    /* An array of numbers recently entered by the user or computed. */
    this.stack = new Array();
    this.stack[0] = 0;

    /** 
     * An array of up to four symbols for the operations. 
     * The symbols should match the names of the properties in opList.
     */
    this.opNames = { "+":"addition", 
                      "-":"subtraction",
                      "*":"multiplicaiton",
                      "/":"division" };

    /**
     * An object that maps the string names of the calculator's 
     * operation buttons to the operation methods above by use
     * of its property names and values. 
     */
    this.opList = { "addition": this.addition,
                    "subtraction": this.subtraction,
                    "multiplicaiton":this.multiplication,
                    "division":this.division };

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
    this.getStackTop = function() {
      return (this.stack.top() === undefined) ? 0 : this.stack.top();
    }

    /**
     * Set the value of the top of the stack to value. 
     * The stack size is unchanged.
     *
     * @param v - The value to set the top of the stack to
     */
    this.setStackTop = function( value ) {
       console.log( "push: " + value );
       this.stack[0] = value; 
    }

   /**
    * Addition operator callback
    */ 
    this.addition = function () {
      console.log("calling addition")
      first = this.stack.pop();
      second = this.stack.pop();
      this.setStackTop( first + second );
    }

    /**
     * Subtraction operator callback
     */ 
    this.subtraction = function() {
      console.log("calling subtraction")
      first = this.stack.pop();
      second = this.stack.pop();
      this.setStackTop( first - second );
    }

    /**
     * Multiplication operator callback
     */ 
    this.multiplication = function () {
      console.log("calling multiplication")
      first = this.stack.pop();    
      second = this.stack.pop();

      this.setStackTop( first * second ); 
    }

    /**
     * Division operator callback
     */ 
    this.division = function () {
      console.log("calling division")
      divisor = this.stack.pop();
      dividend = this.stack.pop(); 
      quotient = dividend/divisor;
      this.setStackTop( quotient );
    }
}

