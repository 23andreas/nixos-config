import MenuBar from "./menubar";

export default (monitor: number) => {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "menubar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: MenuBar()
  });
};
