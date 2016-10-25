import QtQuick 2.0
import "qrc:/Resources/jbQuick.Charts" 1.0

Item {
    id: charts
    anchors.fill: parent

    Column{
        width: parent.width
        height: 50

        Rectangle {
            id: button3
            width: parent.width
            height: 50
            color:"grey"
            MouseArea{
                anchors.fill: parent
                Text{
                    text: qsTr("Back")
                    horizontalAlignment: Text.AlignHCenter
                }

                onClicked:{
                    homeControls.visible = true
                    charts.visible = false
                    home.navigation = "home"
                }
            }
        }
        Row{
            width: parent.width

            Rectangle {
                id: buttonLast10Trx
                width: parent.width
                height: 50
                MouseArea{
                    anchors.fill: parent
                    Text{
                        text: qsTr("Last 10 Trx")
                        horizontalAlignment: Text.AlignHCenter
                    }

                    onClicked:{
                        _ESApplication.chartLast10Trx()
                        chart_line.chartData = {
                            labels:_ESApplication.labelList,
                            datasets: [{
                                    label: "Data",
                                    data: _ESApplication.dataList
                                }]
                        }
                    }
                }
            }

        }

        Chart{
            id: chart_line
            width: 400
            height: 400
            chartType: Charts.ChartType.LINE;
            Component.onCompleted: {
                chartData = {
                    labels:_ESApplication.labelList,
                    datasets: [{
                            label: "Data",
                            data: _ESApplication.dataList
                        }]
                }
            }
        }
    }
}
