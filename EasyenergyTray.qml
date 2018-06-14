import QtQuick 1.1
import Effects 1.0

import qb.components 1.0
import qb.base 1.0

SystrayIcon {
	id: easyenergySystrayIcon
	visible: true
	posIndex: 8000

	onClicked: {
		stage.openFullscreen(app.easyenergyScreenUrl);
	}

	Image {
		id: imgEasyenergy
		anchors.centerIn: parent
		source: "./drawables/easyenergyIcon.png"
	}
}
