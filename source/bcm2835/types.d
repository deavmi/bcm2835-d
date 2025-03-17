/** 
 * Type definitions
 *
 * The types here are defined by
 * this library's own names but
 * their values do link back to
 * that of WiringPi's
 *
 * Authors: Tristan Brice Velloza Kildaire
 */
module bcm2835.types;

import bcm2835.wiringPi : OUTPUT, INPUT;

/** 
 * Pin mode
 *
 * Represented as an unisgned 8-bit
 * integer
 */
public enum Mode : ubyte
{
	/**
	 * Output pin mode
	 */
	Output = OUTPUT,

	/**
	 * Input pin mode
	 */
	Input = INPUT
}

import bcm2835.wiringPi : HIGH, LOW;

/** 
 * Pin state
 *
 * Represented as an unisgned 8-bit
 * integer
 */
public enum State : ubyte
{
	/**
	 * Pin is high
	 */
	High = HIGH,

	/** 
	 * Pin is low
	 */
	Low = LOW
}

/** 
 * Represents a pin
 *
 * An alias for the `ubyte` type
 * which is an 8-bit unsigned
 * integer
 */
public alias Pin = ubyte;

import bcm2835.wiringPi : WPIPinType, WPI_PIN_BCM, WPI_PIN_WPI, WPI_PIN_PHYS;

/** 
 * The addressing mode for
 * the pins
 */
public enum Addressing : ubyte
{
	/**
	 * Broadcom addressing
	 * scheme
	 */
	BCM = WPI_PIN_BCM,

	/**
	 * WiringPi addressing
	 * scheme
	 */
	WPI = WPI_PIN_WPI,

	/**
	 * Pin addressing
	 * scheme
	 */
	PHYS = WPI_PIN_PHYS
}
