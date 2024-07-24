import { type WindowProps } from "types/widgets/window";

interface Props {
  name: string,
  child: WindowProps['child']
}

export const PopupWindow = ({name, child}: Props) =>
  Widget.Window({
    name,
    visible: false,
    setup: w => w.keybind("Escape", () => App.closeWindow(name)),
    child,
    anchor: ["top", "bottom", "right", "left"]
  });

export default PopupWindow;
