import QtQuick 2.0
import QtQuick.Controls 1.4
import "qrc:/Resources/jbQuick.Charts" 1.0

Item {
    id: charts
    anchors.fill: parent

    Column{
        width: parent.width
        height: 50

        Button {
            id: button3
            text: qsTr("Back")
            width: parent.width

            onClicked:{
                homeControls.visible = true
                charts.visible = false
                home.navigation = "home"
            }
        }
        Row{
            width: parent.width

            Button {
                id: buttonLast10Trx
                text: qsTr("Last 10 Trx")
                width: parent.width

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
