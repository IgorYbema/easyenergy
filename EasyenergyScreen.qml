import QtQuick 1.1

import qb.components 1.0

Screen {
	id: easyenergyScreen

	screenTitleIconUrl: "./drawables/easyenergyIcon.png"

	screenTitle: "EasyEnergy"


	// calculate height of bar or text value
	function calculateHeight(maxHeight,tariff) {
		var h = (app.settings.scaleGraph) ?  10 + (maxHeight - 30 - 10) * ((tariff-app.minTariffValue)/(app.maxTariffValue-app.minTariffValue)) :  (maxHeight - 10) * (tariff/app.maxTariffValue)
		return h
	}


	Rectangle {
		id: mainRectangle
		anchors {
			top: parent.top
			bottom: parent.bottom
			left: parent.left
			right: parent.right
			leftMargin: 20               
			rightMargin: 20               
		}
		color: colors.addDeviceBackgroundRectangle
	}

	StandardButton {
		id: btnConfigScreen
		width: 150
		text: "Instellingen"
		anchors.top : mainRectangle.top
		anchors.right : mainRectangle.right
		anchors.rightMargin : 10 
		anchors.topMargin : 10 
		onClicked: {
			if (app.easyenergySettings) {
				app.easyenergySettings.show();
			}
		}
	}

	Text {
		id: tileTitle
		anchors {
			baseline: mainRectangle.top
			baselineOffset: 30
			horizontalCenter: mainRectangle.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.tileTitle
		}
		color: colors.tileTitleColor
		text: "Huidig tarief"
	}


	Text {
		id: txtTariff
		text: "\u20AC" + app.normalizeTariff(app.currentTariffUsage)
		color: app.currentTextColor()
		anchors {
			top: tileTitle.bottom
			topMargin: 0
			horizontalCenter: mainRectangle.horizontalCenter
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: 30
		font.family: qfont.regular.name
	}

	Row {
		id: easyenergyScreenRow
		anchors.bottom: mainRectangle.bottom
		anchors.bottomMargin: 10
		anchors.left: mainRectangle.left
		anchors.leftMargin: 60
		anchors.right: mainRectangle.right
		anchors.rightMargin: 60

		height: isNxt ? 340 : 250
		Repeater {
			id: easyenergyRowRepeater
			model: app.datapoints
			Item {
				height: easyenergyScreenRow.height
				width: (app.datapoints > 0) ? easyenergyScreenRow.width / app.datapoints : 0
				Rectangle {
					id: easyenergyHourBars
					anchors.bottom: parent.bottom
					anchors.bottomMargin: 30
					anchors.horizontalCenter: parent.horizontalCenter
					color: ((index + app.startHour) === app.currentHour) ? "#0099ff" : "#ff6600"
					height: calculateHeight(easyenergyScreenRow.height,app.tariffValues[index])
					width: (easyenergyScreenRow.width / app.datapoints - 5) // two pixels smaller than the parent item to keep gaps between the bars
				}
				Text {
					anchors.bottom: parent.bottom
					anchors.horizontalCenter: parent.horizontalCenter
					text: (index + app.startHour) % 24
					font.pointSize: 12
					color: colors.tileTextColor
					visible: !((index + app.startHour) % 3) //show each 3 hours an x-index
				}
			}
		}
	}		

	Rectangle {
		id: easyenergyQ3Line
		anchors.bottom: easyenergyScreenRow.bottom
		anchors.left: easyenergyScreenRow.left
		width: easyenergyScreenRow.width
		height: 2
		opacity: 0.5
		color: "#ff0000"
		anchors.bottomMargin: 30 + calculateHeight(easyenergyScreenRow.height,app.tariffQ3) 
		border.width: 0
	}

	Text {
		id: q3TariffValue
		text: "\u20AC" + app.normalizeTariff(app.tariffQ3)
		color: colors.tileTitleColor
		anchors.left: mainRectangle.left
		anchors.leftMargin: 5
		anchors.verticalCenterOffset: 0
		anchors.verticalCenter: easyenergyQ3Line.verticalCenter
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: 12
		font.family: qfont.regular.name
	}

	Rectangle {
		id: easyenergyQ1Line
		anchors.bottom: easyenergyScreenRow.bottom
		anchors.left: easyenergyScreenRow.left
		width: easyenergyScreenRow.width
		height: 2
		opacity: 0.5
		color: "#00ff00"
		anchors.bottomMargin: 30 + calculateHeight(easyenergyScreenRow.height,app.tariffQ1) 
		border.width: 0
	}
	Text {
		id: q1TariffValue
		text: "\u20AC" + app.normalizeTariff(app.tariffQ1)
		color: colors.tileTitleColor
		anchors.left: mainRectangle.left
		anchors.leftMargin: 5
		anchors.verticalCenterOffset: 0
		anchors.verticalCenter: easyenergyQ1Line.verticalCenter
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: 12
		font.family: qfont.regular.name
	}

	Text {
		id: maxTariffValueTxt
		text: "\u20AC" + app.normalizeTariff(app.maxTariffValue)
		color: colors.tileTitleColor
		anchors.right: mainRectangle.right
		anchors.rightMargin: 5
		anchors.bottom: easyenergyScreenRow.bottom
		anchors.bottomMargin: 22 + calculateHeight(easyenergyScreenRow.height,app.maxTariffValue)
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: 12
		font.family: qfont.regular.name
	}

	Text {
		id: minTariffValueTxt
		text: "\u20AC" + app.normalizeTariff(app.minTariffValue)
		color: colors.tileTitleColor
		anchors.right: mainRectangle.right
		anchors.rightMargin: 5
		anchors.bottom: easyenergyScreenRow.bottom
		anchors.bottomMargin: 22 + calculateHeight(easyenergyScreenRow.height,app.minTariffValue)
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: 12
		font.family: qfont.regular.name
	}

	Text {
		id: minMaxTxt
		text: "Min/Max"
		color: colors.tileTitleColor
		anchors.right: mainRectangle.right
		anchors.rightMargin: 5
		anchors.bottom: easyenergyScreenRow.bottom
		anchors.bottomMargin: 0 
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: 12
		font.family: qfont.regular.name
	}

	Text {
		id: laagHoogTxt
		text: "Laag/Hoog"
		color: colors.tileTitleColor
		anchors.left: mainRectangle.left
		anchors.leftMargin: 5
		anchors.bottom: easyenergyScreenRow.bottom
		anchors.bottomMargin: 0 
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: 12
		font.family: qfont.regular.name
	}
}
