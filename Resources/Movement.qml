import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: movement
    anchors.fill: parent

    Column{
        width: parent.width

        Button {
            id: button3
            text: qsTr("Back")
            width: parent.width

            onClicked:{
                homeControls.visible = true
                movement.visible = false
                home.navigation = "home"
            }
        }

        Row {
            id: grid1
            width: parent.width
            Rectangle{
                id:paraDate
                height: 50
                width:parent.width/5
                Text{
                    id:txtDate
                    width: parent.width
                    text:"Date"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Row {
            id: grid
            width: parent.width
            Rectangle{
                id:para1
                height: 50
                width:parent.width/5
                Text{
                    id:txtId
                    width: parent.width
                    text:"ID"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id:para2
                height: 50
                width:parent.width/5
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
                width:parent.width/5
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
                width:parent.width/5
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
                width:parent.width/5
                Text{
                    id:txtAmount
                    text:"Amount"
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        ListView {
            id: lstvMovement
            width: parent.width
            height: 500
            highlightRangeMode: ListView.StrictlyEnforceRange
            model: _MovementModel

            delegate:
                Item{
                id:dataDelegate
                width: parent.width
                height: 100

                Column{
                    width: parent.width

                    Row{
                        id:row1
                        width: parent.width
                        height: 50

                        Rectangle{
                            id:valueDate
                            height: 50
                            width:parent.width/5
                            Text{
                                id:valueDatetext
                                text: dateTimeRole
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }
                    Row{
                        id:row2
                        width: parent.width
                        height:50

                        Rectangle{
                            id:value1
                            height: 50
                            width:parent.width/5
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
                            width:parent.width/5
                            Text{
                                id:value2text
                                text:accountRole
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        Rectangle{
                            id:value3
                            height: 50;
                            width:parent.width/5
                            Text{
                                id:para3text
                                text:categoryRole
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        Rectangle{
                            id:value4
                            height: 50;
                            width:parent.width/5
                            Text{
                                id:para4text
                                text:transactionTypeRole
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        Rectangle{
                            id:value5
                            height: 50;
                            width:parent.width/5
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
    }
}
