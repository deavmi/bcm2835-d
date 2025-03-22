import bcm2835;
import std.stdio : writeln;
import core.thread : Thread, dur, Duration;

void main()
{
	writeln("Startup");

	// initialize the driver (this may throw an exception)
	auto driver = new BCM2835();
	writeln("Got driver: ", driver);

	// set the pins as outputs
	Pin pin_1 = 19;
	Pin pin_2 = 20;
	Pin pin_3 = 21;
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
	Duration wait = dur!("seconds")(2);
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
