import Menubar from "./menubar/index";
import applauncher from "./launcher/applauncher";
import { setupDateMenu } from "./menubar/datemenu/DateMenu";

App.config({
  style: "./style.css",

  onConfigParsed: () => {
    setupDateMenu();
  },
  windows: [Menubar(1), applauncher()],
});

export {};
