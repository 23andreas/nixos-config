import { CurrentDateTime } from "../lib/variables";

function up(up: number) {
  const h = Math.floor(up / 60);
  const m = Math.floor(up % 60);
  return `uptime: ${h}:${m < 10 ? "0" + m : m}`;
}

export default () =>
  Widget.Box({
    vertical: true,
    class_name: "date-column vertical",
    children: [
      Widget.Box({
        class_name: "clock-box",
        vertical: true,
        children: [
          Widget.Label({
            class_name: "clock",
            label: CurrentDateTime.bind().as((t) => t.format("%H:%M")!),
          }),
        ],
      }),
      Widget.Box({
        class_name: "calendar",
        children: [
          Widget.Calendar({
            hexpand: true,
            hpack: "center",
          }),
        ],
      }),
    ],
  });
