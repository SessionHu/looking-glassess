import std.array : array;
import std.process : execv;
import std.regex : ctRegex, splitter;
import std.stdio : stdout;

void dig(string list) {
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  execv("/usr/bin/dig", ["dig"] ~ list.splitter(ctRegex!r"\s+").array());
}
