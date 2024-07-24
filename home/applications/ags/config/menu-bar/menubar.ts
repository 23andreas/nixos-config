//const notifications = await Service.import("notifications");

import Workspaces from "./widgets/workspaces/Workspaces";
import CurrentTime from "./widgets/CurrentTime";
import Tray from "./widgets/tray/Tray";
import SystemIndicators from "./widgets/system-indicators/SystemIndicators";

// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
//function Notification() {
//  const popups = notifications.bind("popups");
//  return Widget.Box({
//    class_name: "notification",
//    visible: popups.as((p) => p.length > 0),
//    children: [
//      Widget.Icon({
//        icon: "preferences-system-notifications-symbolic",
//      }),
//      Widget.Label({
//        label: popups.as((p) => p[0]?.summary || ""),
//      }),
//    ],
//  });
//}
//

const LeftSection = () =>
  Widget.Box({
    spacing: 0,
    hexpand: true,
    children: [Workspaces(), Tray()],
  });

const CenterSection = () =>
  Widget.Box({
    spacing: 8,
    hexpand: true,
    children: [CurrentTime()],
  });

const RightSection = () =>

  Widget.Box({
    spacing: 8,
    hexpand: true,
    children: [SystemIndicators()],
    hpack: "end",
  });

export const MenuBar = () => {
  return Widget.CenterBox({
    className: 'container',
    start_widget: LeftSection(),
    center_widget: CenterSection(),
    end_widget: RightSection(),
  });
}

export default MenuBar;
