import { Chip } from "elements/index";
import * as utils from "../../utils";
import type { Client } from "types/service/hyprland";

const hyprland = await Service.import("hyprland");

const switchToWorkspace = (id: number) => {
  hyprland.messageAsync(`dispatch workspace ${id}`);
};


const ClientIcons = (workspaceId: number) => {
  const clients: Client[] = JSON.parse(hyprland.message("j/clients"));
  const swallowed = clients.filter((c) => c.swallowing !== "0x0");

  return clients
    .filter((client) => client.workspace.id === workspaceId)
    .filter((client) => !swallowed.some((c) => c.swallowing === client.address))
    .sort((a, b) => a.at[0] - b.at[0])
    .map((client) => {
      return Widget.Icon({
        className: "app-icon",
        vexpand: false,
        icon: utils.getIconName(client),
        size: 14,
      });
    });
};

const WorkspaceLabel = (id: number) =>
  Widget.Label({
    className: "workspace-label",
    label: `${id}`,
  });

const WorkspaceItem = (workspaceId: number) =>
  Widget.Button({
    attribute: {
      workspaceId: workspaceId,
    },
    className: `workspace-${workspaceId} workspace-item`,
    child: Chip({ children: [WorkspaceLabel(workspaceId), ...ClientIcons(workspaceId)] }),
    setup: (self) =>
      self.hook(hyprland, () => {
        self.toggleClassName(
          "active",
          hyprland.active.workspace.id === workspaceId
        );
      }),
  });

const WorkspaceList = () =>
  Widget.Box({
    className: "workspace-list",
    spacing: 2,
    children: hyprland.workspaces
      .filter((w) => !w.name.includes("special:"))
      .sort((a, b) => a.id - b.id)
      .map((workspace) => WorkspaceItem(workspace.id)),
  });

const Workspaces = () =>
  Widget.Button({
    className: "group",
    onScrollUp: () => {
      if (hyprland.active.workspace.id > 0) {
        switchToWorkspace(hyprland.active.workspace.id - 1);
      }
    },
    onScrollDown: () => {
      if (hyprland.active.workspace.id < 10) {
        switchToWorkspace(hyprland.active.workspace.id + 1);
      }
    },
    child: hyprland.bind("workspaces").as(WorkspaceList),
  });

export default Workspaces;
