import { CurrentDateTime } from "../lib/variables";

const CurrentDateTimeFormatted = Utils.derive(
  [CurrentDateTime],
  (t) => t.format("%A%e. %B %H:%M") || "N/A"
);

export default () =>
  Widget.Button({
    child: Widget.Label({
      justification: "center",
      label: CurrentDateTimeFormatted.bind(),
    }),
  });
