import std.process : execv;
import std.stdio : stdout;
import std.system : OS, os;

void broute(bool all, string dst) {
  auto cmd = "show route ";
  if (all) cmd ~= "all ";
  if (dst.length > 0) cmd ~= "for " ~ dst;
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  static if (os == OS.linux) {
    execv("/usr/sbin/birdc", ["birdc", "-r", cmd]);
  } else {
    execv("/usr/local/sbin/birdc", ["birdc", "-r", cmd]);
  }
}
