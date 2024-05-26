import * as utils from "../utils";
import type { Client, Monitor } from "types/service/hyprland";

const hyprland = await Service.import("hyprland");

const switchToWorkspace = (workspace) => {
  hyprland.messageAsync(`dispatch workspace ${workspace}`);
};

const WorkspaceClientIcons = (id: number) => {
  const clients: Client[] = JSON.parse(hyprland.message("j/clients"));
  const swallowed = clients.filter((c) => c.swallowing !== "0x0");

  return clients
    .filter((client) => client.workspace.id === id)
    .filter((client) => !swallowed.some((c) => c.swallowing === client.address))
    .sort((a, b) => a.at[0] - b.at[0])
    .map((client) => {
      // console.log(client);
      return Widget.Icon({
        className: "app-icon",
        vexpand: false,
        icon: utils.getIconName(client),
        size: 16,
      });
    });
};

function WorkspaceLabel(id: number) {
  return Widget.Label({
    className: "workspace-label",
    label: `${id}`,
  });
}

// TODO RENAME ME
const WorkspaceClientsS = (id: number) => {
  return Widget.Box({
    children: [WorkspaceLabel(id), ...WorkspaceClientIcons(id)],
  });
};

const WorkspaceButton = (workspaceId) =>
  Widget.Button({
    attribute: {
      workspaceId: workspaceId,
    },
    className: `workspace-${workspaceId}-button`,
    child: WorkspaceClientsS(workspaceId),
    setup: (self) =>
      self.hook(hyprland, () => {
        self.toggleClassName(
          "active",
          hyprland.active.workspace.id === workspaceId
        );
      }),
  });

const WorkspacesList = () =>
  Widget.Box({
    className: "workspaces-list",
    children: hyprland.workspaces
      .filter((w) => !w.name.includes("special:"))
      .sort((a, b) => a.id - b.id)
      .map((workspace) => WorkspaceButton(workspace.id)),
  });

export default () =>
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
    child: hyprland.bind("workspaces").as(WorkspacesList),
  });
