/**
 * Driver implementation
 *
 * Authors: Tristan Brice Velloza Kildaire
 */
module bcm2835.driver;

version(DBG_PRINT)
{
	import bcm2835.logging;
}

// WiringPi definitions
import bcm2835.wiringPi : pinMode;
import bcm2835.wiringPi : digitalWrite;

// types
import bcm2835.types;


/** 
 * Driver exceptions
 */
public final class BCM2835Exception : Exception
{
	this(string msg)
	{
		super(msg);
	}
}

/** 
 * The driver itself
 */
public class BCM2835 // TODO: Move to a struct type
{
	private alias dexcp = BCM2835Exception;
	import niknaks.meta : isVariadicArgsOf;

	private Addressing _a;
	
	/** 
	 * Constructs a new driver
	 * instance using Broadcom
	 * addressing
	 */
	this()
	{
		this(Addressing.BCM);
	}

	/** 
	 * Constructs a new driver instance
	 * with the given addressing mode.
	 *
	 * See_Also: `Addressing` for information
	 * Params:
	 *   aType = the addressing mode
	 */
	this(Addressing aType)
	{
		this._a = aType;
		setup(this._a);
	}

	// TODO: Neaten up
	private void setup(Addressing aType)
	{
		int _s;
		version(WPI_NEW_SETUP)
		{
			version(DBG_PRINT) { DEBUG("About to call wiringPiSetupGpioDevice()..."); }

			// fixme: try get wpi3 working, or document which version
			// works and which doesn't -0 link time error with my RPi's
			// current object file
			import bcm2835.wiringPi : wiringPiSetupGpioDevice;
			import bcm2835.wiringPi : WPIPinType;
			_s = wiringPiSetupGpioDevice(cast(WPIPinType)aType);
			version(DBG_PRINT) { DEBUG("wiringPiSetupGpioDevice(): ", _s); }
		}
		else
		{
			import bcm2835.wiringPi : wiringPiSetupGpio, wiringPiSetupPhys, wiringPiSetup;

			if(aType == Addressing.WPI)
			{
				version(DBG_PRINT) { DEBUG("About to call wiringPiSetup()..."); }
				_s = wiringPiSetup();
			}
			else if(aType == Addressing.BCM)
			{
				version(DBG_PRINT) { DEBUG("About to call wiringPiSetupGpio()..."); }
				_s = wiringPiSetupGpio();
			}
			else if(aType == Addressing.PHYS)
			{
				version(DBG_PRINT) { DEBUG("About to call wiringPiSetupPhys()..."); }
				_s = wiringPiSetupPhys();
			}
		}

		version(DBG_PRINT) { DEBUG("Setup function return value: ", _s); }

		if(_s)
		{
			version(DBG_PRINT) { ERROR("Setup function returned with a non-zero value"); }
			throw new dexcp("Setup function returned non 1 value");
		}
	}

	/** 
	 * Sets the mode of the
	 * given pin
	 *
	 * Params:
	 *   p = the pin
	 *   m = the mode
	 */
	public void setType(Pin p, Mode m)
	{
		version(DBG_PRINT) { DEBUG("Setting ", p, " to mode ", m); }
		pinMode(p, m);
	}

	/** 
	 * Sets the given pins to
	 * the given mode
	 *
	 * Params:
	 *   pins = the pins
	 *   m = the mode
	 */
	public void setType(T...)(T pins, Mode m)
	if(isVariadicArgsOf!(Pin, T))
	{
		// generate calls based on variadic arguments
		static foreach(p; pins)
		{
			setType(p, m);
		}
	}

	/** 
	 * Sets the given pins to
	 * output mode
	 *
	 * Params:
	 *   pins = the pins
	 */
	public void output(T...)(T pins)
	{
		setType(pins, Mode.Output);
	}

	/** 
	 * Sets the given pins
	 * to input mode
	 *
	 * Params:
	 *   pins = the pins
	 */
	public void input(T...)(T pins)
	{
		setType(pins, Mode.Input);
	}

	/** 
	 * Sets the given pin to the
	 * given state
	 *
	 * Params:
	 *   p = the pin
	 *   s = the state
	 */
	public void setState(Pin p, State s)
	{
		version(DBG_PRINT) { DEBUG("Setting ", p, " to state ", s); }
		digitalWrite(p, s);
	}

	/** 
	 * Sets the given pins to the
	 * given state
	 *
	 * Params:
	 *   pins = the pins
	 *   s = the state
	 */
	public void setState(T...)(T pins, State s)
	if(isVariadicArgsOf!(Pin, T))
	{
		// generate calls based on variadic arguments
		static foreach(p; pins)
		{
			setState(p, s);
		}
	}

	/** 
	 * Sets the given pins
	 * to low
	 *
	 * Params:
	 *   pins = the pins
	 */
	public void low(T...)(T pins)
	{
		setState(pins, State.Low);
	}

	/** 
	 * Sets the given pins
	 * to high
	 *
	 * Params:
	 *   pins = the pins
	 */
	public void high(T...)(T pins)
	{
		setState(pins, State.High);
	}
}
