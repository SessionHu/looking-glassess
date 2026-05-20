import std.process : execv;
import std.stdio : stdout;
import std.system : OS, os;

void proto(bool all, string name) {
  auto cmd = "show protocols ";
  if (all) cmd ~= "all ";
  if (name.length > 0) cmd ~= name;
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  static if (os == OS.linux) {
    execv("/usr/sbin/birdc", ["birdc", "-r", cmd]);
  } else {
    execv("/usr/local/sbin/birdc", ["birdc", "-r", cmd]);
  }
}
