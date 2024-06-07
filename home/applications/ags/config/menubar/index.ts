const notifications = await Service.import("notifications");
const systemtray = await Service.import("systemtray");

import Workspaces from "./widgets/Workspaces";
import CurrentTime from "./widgets/CurrentTime";
import Volume from "./widgets/Volume";

// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
function Notification() {
  const popups = notifications.bind("popups");
  return Widget.Box({
    class_name: "notification",
    visible: popups.as((p) => p.length > 0),
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
      }),
      Widget.Label({
        label: popups.as((p) => p[0]?.summary || ""),
      }),
    ],
  });
}

function SysTray() {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      })
    )
  );

  return Widget.Box({
    className: "system-tray",
    children: items,
  });
}

// layout of the bar
function Left() {
  return Widget.Box({
    spacing: 8,
    hexpand: true,
    children: [Workspaces(), SysTray()],
  });
}

function Center() {
  return Widget.Box({
    spacing: 8,
    hexpand: true,
    children: [CurrentTime()],
  });
}

function Right() {
  return Widget.Box({
    hpack: "end",
    hexpand: true,
    spacing: 8,
    children: [Volume()],
  });
}

export default (monitor: number) => {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
};
