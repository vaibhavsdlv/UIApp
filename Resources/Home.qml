import QtQuick 2.0
import QtQuick.Controls 1.4
import "qrc:/qml/Resources"

Rectangle {
    id: home
    height:720
    width:480
    visible:true

    property string navigation:"home"

    Transaction{
        id: transaction
        visible:false
    }

    Movement{
        id: movement
        visible: false
    }

    Charts{
        id: charts
        visible: false
    }

    About{
        id: about
        visible: false
    }

    Column {
        id: homeControls
        anchors.fill: parent

        Row {
            id: row2
            width: parent.width
            height: 50

            Button {
                id: button3
                text: qsTr("+")
                width: parent.width/3
                onClicked:{
                    callTransaction("+")
                }
            }

            Button {
                id: button2
                text: qsTr("-")
                width: parent.width/3
                onClicked:{
                    callTransaction("-")
                }
            }

            Button {
                id: button1
                text: qsTr("List All")
                width: parent.width/3
                onClicked: {
                    homeControls.visible = false
                    movement.visible = true
                    home.navigation = "movement"
                }
            }
        }
        Row {
            id: rowMiscOps
            width: parent.width
            height: 50

            Button {
                id: btnClearDB
                text: qsTr("Clear DB")
                width: parent.width/3
                onClicked:{
                    _ESApplication.clearDB()
                }
            }

            Button {
                id: button4
                text: qsTr("Charts")
                width:parent.width/3
                onClicked:{
                    homeControls.visible = false
                    charts.visible = true
                    home.navigation = "charts"
                }
            }

            Button {
                id: button5
                text: qsTr("About")
                width:parent.width/3
                onClicked:{
                    homeControls.visible = false
                    about.visible = true
                    home.navigation = "about"
                }
            }

        }
        Image {
            id: image1
            width: parent.width
            height: 100
            source: "qrc:/qml/Resources/money.png"
        }

        Label {
            height: 50
            width: parent.width
            id: lblLast10Trx
            text: qsTr("Last 10 Transactions")
            horizontalAlignment: Text.AlignHCenter

        }

        Row {
            id: grid
            width: parent.width
            Rectangle{
                id:para1
                height: 50
                width: parent.width/5
                Text{
                    id:txtId
                    text:"ID"
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id:para2
                height: 50
                width: parent.width/5
                Text{
                    id:txtAccount
                    text:"Account"
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id:para3
                height: 50
                width: parent.width/5
                Text{
                    id:txtCategory
                    text:"Category"
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id:para4
                height: 50
                width: parent.width/5
                Text{
                    id:txtTrxType
                    text:"Transaction Type"
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id:para5
                height: 50
                width: parent.width/5
                Text{
                    id:txtAmount
                    text:"Amount"
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        ListView {
            id: lstvLast10Trx
            width: parent.width
            height: 400
            highlightRangeMode: ListView.StrictlyEnforceRange
            model: _last10TrxModel
            interactive:false

            delegate:
                Item{
                id:dataDelegate
                width: parent.width
                height: 30

                Row{
                    id:rowGrid
                    width: parent.width

                    Rectangle{
                        id:value1
                        height: 50
                        width: parent.width/5
                        Text{
                            id:value1text
                            text: idRole
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Rectangle{
                        id:value2
                        height: 50
                        width: parent.width/5
                        Text{
                            id:value2text
                            text:accountRole
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Rectangle{
                        id:value3
                        height: 50
                        width: parent.width/5
                        Text{
                            id:para3text
                            text:categoryRole
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Rectangle{
                        id:value4
                        height: 50
                        width: parent.width/5
                        Text{
                            id:para4text
                            text:transactionTypeRole
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Rectangle{
                        id:value5
                        height: 50
                        width: parent.width/5
                        Text{
                            id:para5text
                            text:amountRole
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }


                }
            }
        }
    }

    Connections{
        target: transaction
        onRequestRefresh:{
            // refresh lstvLast10Trx list here
            _ESApplication.refillMovementModel();
            _ESApplication.refillLast10TrxModel();
        }
    }

    function callTransaction(strType)
    {
        homeControls.visible = false
        home.navigation = strType
        transaction.visible = true
        _ESApplication.setTrxType(strType)
    }
}
