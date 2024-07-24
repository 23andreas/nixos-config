import { Applications } from "resource:///com/github/Aylur/ags/service/applications.js";
import type { Client } from "types/service/hyprland";


const queryApplications = (query: string) => {
  const applications = new Applications();
  return applications.query(query);
};

export function getIconName(client: Client): string {
  const classQueryResults = queryApplications(client?.class);

  if (classQueryResults.length && classQueryResults[0].icon_name) {
    return classQueryResults[0].icon_name;
  }

  const initialTitleQueryResults = queryApplications(client?.initialTitle);

  if (
    initialTitleQueryResults.length &&
    initialTitleQueryResults[0].icon_name
  ) {
    return initialTitleQueryResults[0].icon_name;
  }

  return "missing";
}
