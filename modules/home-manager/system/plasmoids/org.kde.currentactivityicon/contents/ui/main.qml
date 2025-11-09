import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami
import org.kde.activities as Activities

PlasmoidItem {
    id: root

    // ActivityInfo with :current automatically tracks the current activity
    Activities.ActivityInfo {
        id: currentActivity
        activityId: ":current"

        // Update icon immediately when activity icon changes
        onIconChanged: function() {
            Plasmoid.icon = currentActivity.icon || "activities"
        }
    }

    // Define fullRepresentation so Plasma knows this can expand
    fullRepresentation: Item {
        Layout.minimumWidth: Kirigami.Units.gridUnit * 12
        Layout.minimumHeight: Kirigami.Units.gridUnit * 12

        ColumnLayout {
            anchors.centerIn: parent

            Kirigami.Icon {
                source: currentActivity.icon || "activities"
                Layout.preferredWidth: Kirigami.Units.iconSizes.huge
                Layout.preferredHeight: Kirigami.Units.iconSizes.huge
                Layout.alignment: Qt.AlignHCenter
            }

            PlasmaComponents.Label {
                text: currentActivity.name || "No activity"
                font.pointSize: 14
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    Component.onCompleted: {
        // Set initial icon
        Plasmoid.icon = currentActivity.icon || "activities"
    }
}

