import { Chip } from '../../../elements/index';

const systemtray = await Service.import("systemtray");

export const Tray = () => {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        child: Widget.Icon({ icon: item.bind("icon"), size: 14 }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      })
    )
  );

  return Chip({
    children: items,
    classNames: ['secondary']
  });
}

export default Tray;
