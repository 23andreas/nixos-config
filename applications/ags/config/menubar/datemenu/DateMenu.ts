import PopupWindow from "../PopupWindow";
import NotificationColumn from "./NotificationColumn";
import DateColumn from "./DateColumn";

const layout = `top-center`;

const Settings = () =>
  Widget.Box({
    class_name: "datemenu horizontal",
    vexpand: false,
    children: [
      NotificationColumn(),
      Widget.Separator({ orientation: 1 }),
      DateColumn(),
    ],
  });

const DateMenu = () =>
  PopupWindow({
    name: "datemenu",
    exclusivity: "exclusive",
    transition: "slide_down",
    layout,
    child: Settings(),
  });

export function setupDateMenu() {
  App.addWindow(DateMenu());
  //   App.removeWindow("datemenu");
  // App.addWindow(DateMenu());
}
