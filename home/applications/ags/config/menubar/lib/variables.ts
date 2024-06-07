import GLib from "gi://GLib";

export const CurrentDateTime = Variable(GLib.DateTime.new_now_local(), {
  poll: [1000, () => GLib.DateTime.new_now_local()],
});
