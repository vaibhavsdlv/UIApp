import QtQuick 2.0

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

            Rectangle {
                id: button3
                width: parent.width/3
                height:parent.height
                color: "grey"
                MouseArea{
                    anchors.fill: parent
                    Text{
                        text: qsTr("+")
                        horizontalAlignment: Text.AlignHCenter
                    }
                    onClicked:{
                        callTransaction("+")
                    }
                }
            }

            Rectangle {
                id: button2
                width: parent.width/3
                height:parent.height
                color: "grey"
                MouseArea{
                    anchors.fill: parent
                    Text{
                        text: qsTr("-")
                        horizontalAlignment: Text.AlignHCenter
                    }
                    onClicked:{
                        callTransaction("-")
                    }
                }
            }

            Rectangle {
                id: button1
                width: parent.width/3
                height:parent.height
                color: "grey"
                MouseArea{
                    anchors.fill: parent
                    Text{
                        text: qsTr("List All")
                        horizontalAlignment: Text.AlignHCenter
                    }
                    onClicked: {
                        homeControls.visible = false
                        movement.visible = true
                        home.navigation = "movement"
                    }
                }
            }
        }
        Row {
            id: rowMiscOps
            width: parent.width
            height: 50

            Rectangle {
                id: btnClearDB
                width: parent.width/3
                height:parent.height
                color:"grey"
                MouseArea{
                    anchors.fill: parent
                    Text{
                        text: qsTr("Clear DB")
                        horizontalAlignment: Text.AlignHCenter
                    }
                    onClicked:{
                        _ESApplication.clearDB()
                    }
                }
            }

            Rectangle {
                id: button4
                width:parent.width/3
                height:parent.height
                color:"grey"
                MouseArea{
                    anchors.fill: parent
                    Text{
                        text: qsTr("Charts")
                        horizontalAlignment: Text.AlignHCenter
                    }
                    onClicked:{
                        homeControls.visible = false
                        charts.visible = true
                        home.navigation = "charts"
                    }
                }
            }

            Rectangle {
                id: button5
                width:parent.width/3
                height:parent.height
                color:"grey"
                MouseArea{
                    anchors.fill: parent
                    Text{
                        text: qsTr("About")
                        horizontalAlignment: Text.AlignHCenter
                    }
                    onClicked:{
                        homeControls.visible = false
                        about.visible = true
                        home.navigation = "about"
                    }
                }
            }

        }
        Image {
            id: image1
            width: parent.width
            height: 100
            source: "qrc:/qml/Resources/money.png"
        }

        Rectangle {
            height: 50
            width: parent.width
            id: lblLast10Trx
            Text{
                text: qsTr("Last 10 Transactions")
                horizontalAlignment: Text.AlignHCenter
            }
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
