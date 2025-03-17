/**
 * Logging utilities
 */
module bcm2835.logging;

import gogga;
import gogga.extras;
import dlog.basic : Level, FileHandler;
import std.stdio : stdout;

/**
 * The logger instance
 * shared amongst a single
 * thread (TLS)
 */
private GoggaLogger logger;

/**
 * Initializes a logger instance
 * per thread (TLS)
 */
static this()
{
    logger = new GoggaLogger();

    GoggaMode mode = GoggaMode.RUSTACEAN;
    logger.mode(mode);

    Level level = Level.DEBUG;

    logger.setLevel(level);
    logger.addHandler(new FileHandler(stdout));
}

// Bring in helper methods
mixin LoggingFuncs!(logger);
