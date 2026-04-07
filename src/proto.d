import std.process : execv;
import std.stdio : stdout;

void proto(bool all, string name) {
  auto cmd = "show protocols ";
  if (all) cmd ~= "all ";
  if (name.length > 0) cmd ~= name;
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  execv("/usr/sbin/birdc", ["birdc", "-r", cmd]);
}
