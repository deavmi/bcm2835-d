bcm2835-d
=========

D wrapper for [WiringPi](https://github.com/WiringPi/WiringP)(https://github.com/WiringPi/WiringP) (Raspberry Pi GPIO library) complete with nice abstractions and a clear implementation.

## How to use

It's very easy. First add the package with:

```bash
dub add bcm2835-d
```

Then write some code like this:

```d
import bcm2835;
import std.stdio;
import core.thread : Thread, dur, Duration;

void main()
{
	writeln("Startup");

	// initialize the driver (this may throw an exception)
	auto driver = new BCM2835();
	writeln("Got driver: ", driver);

	// set the pins as outputs
	Pin pin_1 = 18;
	Pin pin_2 = 23;
	Pin pin_3 = 24;
	driver.output(pin_1, pin_2, pin_3);

	// drive them all low
	driver.low(pin_1);
	driver.low(pin_2);
	driver.low(pin_3);

	driver.setState(pin_1, pin_2, pin_3, State.Low);
	Thread.sleep(dur!("seconds")(1));
	driver.setState(pin_1, pin_2, pin_3, State.High);
	Thread.sleep(dur!("seconds")(1));
	driver.setState(pin_1, pin_2, pin_3, State.Low);
	Thread.sleep(dur!("seconds")(1));

	// do a fancy little light affect
	Duration wait = dur!("msecs")(100);
	while(true)
	{
		writeln("red");
		
		driver.setState(pin_1, State.High);
		driver.setState(pin_2, State.Low);
		driver.setState(pin_3, State.Low);

		Thread.sleep(wait);

		writeln("blue");
		driver.setState(pin_1, State.Low);
		driver.setState(pin_2, State.High);
		driver.setState(pin_3, State.Low);

		Thread.sleep(wait);

		writeln("green");
		driver.setState(pin_1, State.Low);
		driver.setState(pin_2, State.Low);
		driver.setState(pin_3, State.High);
		
		Thread.sleep(wait);
	}
}
```

You can also see an example in the `testing/` directory,
run the following to try it out (it will use root to run
as we need access to the GPIO):

```bash
cd testing/
./test.sh
```

### Debugging

Set the build flag `DBG_PRINT` for debug prints to be enabled.

## Building

You can build by running:

```
dub build
```

Note, that you may want to specify the `WPI_NEW_SETUP` flag on the command-line (or via your project's `dub.json` with the `"versions"` array) _if_ you want to make use of the newer functions from the WiringPi library that are only available in version 3 and later; by default we use the version 2 methods.

## Todo

- [ ] Remove `gogga` dependency when not in debug build
- [ ] Add `stateRead` (`digitalRead()`) support
- [ ] If I really want to I could also add support for the plethora of other features WiringPi offers

## Dependencies

You need to install the `` package so that the share
object files required during link time are available.

The actual linking is handled all automatically by
Dub, so you need not worry about manually specifying
the library's name.

## License

The license for this project is the LGPL-2.1-only.

### Licenses of included components

The `wiringPi.h` header file, used for type definitions, is stored
at `source/bcm2835/wiringPi.c` (extension renamed for ImportC compatiblility). This is from the [WiringPi](https://github.com/WiringPi/WiringP) project which itself is licensed under the LGPL v3.

## Special thanks

I am very thankful for the team behind the [WiringPi](https://github.com/WiringPi/WiringP) project not only for creating a library that exposes the GPIO in a simple way but **also** for licensing it in the way they did.

I _highly_ recommend that you donate to them - you can go and open up an issue on their GitHub repository and send them some money!