import Menubar from "./menu-bar/index";
import applauncher from "./launcher/applauncher";
import Gdk from "gi://Gdk"
import Gtk from "gi://Gtk?version=3.0"

//import { setupDateMenu } from "./menu-bar/datemenu/DateMenu";

const css = `/tmp/ags/styles.css`

export function forMonitors(widget: (monitor: number) => Gtk.Window) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1
  return range(n, 0).flatMap(widget)
}

/**
 * @returns [start...length]
 */
export function range(length: number, start = 1) {
  return Array.from({ length }, (_, i) => i + start)
}

App.config({
  style: css,
  onConfigParsed: () => {
    //setupDateMenu();
  },
  windows: [...forMonitors(Menubar), applauncher()],
});

export { };
