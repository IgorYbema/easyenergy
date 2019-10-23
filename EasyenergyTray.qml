import QtQuick 1.1

import qb.components 1.0
import qb.base 1.0

SystrayIcon {
	id: easyenergySystrayIcon
	visible: true
	posIndex: 8000
	property string objectName : "easyenergySystray"

	onClicked: {
		stage.openFullscreen(app.easyenergyScreenUrl);
	}

	Image {
		id: imgEasyenergy
		anchors.centerIn: parent
		source: "./drawables/easyenergyIcon.png"
	}
}
