import std.array : array;
import std.process : execv;
import std.regex : ctRegex, match, splitter;
import std.stdio : stdout;
import std.system : OS, os;

void dig(string list) {
  if (list.match(ctRegex!r"^(.+\s)?-[^\s]*(f|k).*$")) {
    stdout.write("Status: 403 Forbidden\r\n");
    stdout.write("content-type: text/plain\r\n\r\n");
    stdout.writeln("-f and -k not allowed here");
    return;
  }
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  const cmd = ["dig"] ~ list.splitter(ctRegex!r"\s+").array();
  static if (os == OS.linux) {
    execv("/usr/bin/dig", cmd);
  } else {
    execv("/usr/local/bin/dig", cmd);
  }
}
