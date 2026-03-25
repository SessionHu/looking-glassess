import std.process : execv;
import std.stdio : stdout;

void broute(bool all, string dst) {
  auto cmd = ["birdc", "-r", "show", "route"];
  if (all) cmd ~= ["all"];
  if (dst.length > 0) cmd ~= ["for", dst];
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  execv("/usr/sbin/birdc", cmd);
}
