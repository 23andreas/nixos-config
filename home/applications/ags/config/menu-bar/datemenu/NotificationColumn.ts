import { type Notification as Notif } from "types/service/notifications";
import Notification from "../notifications/Notification";

const transitionDuration = 200;
const notificationsWidth = 400;

const notifications = await Service.import("notifications");
const notifs = notifications.bind("notifications");

const Animated = (n: Notif) =>
  Widget.Revealer({
    transition_duration: transitionDuration,
    transition: "slide_down",
    child: Notification(n),
    setup: (self) =>
      Utils.timeout(transitionDuration, () => {
        if (!self.is_destroyed) self.reveal_child = true;
      }),
  });

const ClearButton = () =>
  Widget.Button({
    on_clicked: notifications.clear,
    sensitive: notifs.as((n) => n.length > 0),
    child: Widget.Box({
      children: [
        Widget.Label("Clear "),
        Widget.Icon({
          icon: notifs.as((n) =>
            n.length > 0
              ? "user-trash-full-symbolic"
              : "user-trash-empty-symbolic"
          ),
        }),
      ],
    }),
  });

const Header = () =>
  Widget.Box({
    class_name: "header",
    children: [
      Widget.Label({ label: "Notifications", hexpand: true, xalign: 0 }),
      ClearButton(),
    ],
  });

const NotificationList = () => {
  const map: Map<number, ReturnType<typeof Animated>> = new Map();
  const box = Widget.Box({
    vertical: true,
    children: notifications.notifications.map((n) => {
      const w = Animated(n);
      map.set(n.id, w);
      return w;
    }),
    visible: notifs.as((n) => n.length > 0),
  });

  function remove(_: unknown, id: number) {
    const n = map.get(id);
    if (n) {
      n.reveal_child = false;
      Utils.timeout(transitionDuration, () => {
        n.destroy();
        map.delete(id);
      });
    }
  }

  return box.hook(notifications, remove, "closed").hook(
    notifications,
    (_, id: number) => {
      if (id !== undefined) {
        if (map.has(id)) remove(null, id);

        const n = notifications.getNotification(id)!;

        const w = Animated(n);
        map.set(id, w);
        box.children = [w, ...box.children];
      }
    },
    "notified"
  );
};

const Placeholder = () =>
  Widget.Box({
    class_name: "placeholder",
    vertical: true,
    vpack: "center",
    hpack: "center",
    vexpand: true,
    hexpand: true,
    visible: notifs.as((n) => n.length === 0),
    children: [
      Widget.Icon("notifications-disabled-symbolic"),
      Widget.Label("Your inbox is empty"),
    ],
  });

export default () =>
  Widget.Box({
    class_name: "notifications",
    css: `min-width: ${notificationsWidth}px`,
    vertical: true,
    children: [
      Header(),
      Widget.Scrollable({
        vexpand: true,
        hscroll: "never",
        class_name: "notification-scrollable",
        child: Widget.Box({
          class_name: "notification-list vertical",
          vertical: true,
          children: [NotificationList(), Placeholder()],
        }),
      }),
    ],
  });