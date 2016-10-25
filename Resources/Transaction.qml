import QtQuick 2.0

Rectangle{
    id: transaction
    anchors.fill: parent

    signal requestRefresh()
    signal newTransaction()

    onVisibleChanged: {
        if(visible === true)
        {
            if(home.navigation === "+")
            {
                lblMinus.visible = false
                lblPlus.visible = true
                rowIncCategory.visible = true
                rowExpCategory.visible = false
            }
            else if(home.navigation === "-")
            {
                lblPlus.visible = false
                lblMinus.visible = true
                rowIncCategory.visible = false
                rowExpCategory.visible = true
            }
        }
    }

    Column {
        id: column1
        width: parent.width
        height: 400

        Rectangle {
            id: button3
            width: parent.width
            height:50
            color:"grey"
            MouseArea{
                anchors.fill: parent
                Text{
                    text: qsTr("Back")
                    horizontalAlignment: Text.AlignHCenter
                }

                onClicked:{
                    homeControls.visible = true
                    transaction.visible = false
                    home.navigation = "home"
                }
            }
        }

        Row {
            id: rowTxType
            width: parent.width
            height: 50

            Rectangle {
                id: lblPlus
                width: parent.width/2
                height:parent.height
                Text{
                    text: qsTr("+")
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle {
                id: lblMinus
                width: parent.width/2
                height:parent.height
                Text{
                    text: qsTr("-")
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
        Row {
            id: rowAmount
            width: parent.width
            height: 50

            Rectangle {
                id: lblAmount
                width: parent.width/2
                height: parent.height
                Text{
                    text: qsTr("Amount:")
                }
            }

            TextEdit{
                id: txtAmount
                width: parent.width/2
                text:_ESApplication.amount

                onTextChanged: {
                    _ESApplication.amount = txtAmount.text
                }
            }
        }

        Row {
            id: rowAccount
            width: parent.width
            height: 50


            Rectangle {
                id: lblAccount
                width: parent.width/2
                height: parent.height
                Text{
                    text: qsTr("Account:")
                }
            }

            //            ComboBox {
            //                id: cbAccount
            //                editable: false
            //                model: [ "Card1", "Cash", "Savings" ]
            //                width: parent.width/2

            //                onCurrentTextChanged:  {
            //                    _ESApplication.account = cbAccount.currentText
            //                }
            //            }
        }

        Row {
            id: rowExpCategory
            width: parent.width
            height: 50

            Rectangle {
                id: lblExpCategory
                width:parent.width/2
                height: parent.height
                Text{
                    text: qsTr("Category:")
                }
            }

            //            ComboBox {
            //                id: cbExpCategory
            //                editable: false
            //                width: parent.width/2
            //                model: [ "Clothing", "Drinks", "Education", "Food", "Fuel", "Fun", "Health", "Highway", "Hotel", "Merchandise", "Other", "Personal", "Pets", "Restaurant", "Tips", "Transport" ]

            //                onCurrentTextChanged: {
            //                    _ESApplication.category = cbExpCategory.currentText
            //                }
            //            }
        }

        Row {
            id: rowIncCategory
            width: parent.width
            height: 50

            Rectangle {
                id: lblIncCategory
                width:parent.width/2
                height: parent.height
                Text{
                    text: qsTr("Category:")
                }
            }

            //            ComboBox {
            //                id: cbIncCategory
            //                editable: false
            //                width: parent.width/2
            //                model: [ "Loan", "Salary", "Sales" ]

            //                onCurrentTextChanged: {
            //                    _ESApplication.category = cbIncCategory.currentText
            //                }
            //            }
        }

        Row {
            id: rowDesc
            width: parent.width
            height: 50

            Rectangle {
                id: lblDesc
                width: parent.width/2
                height: parent.height
                Text{
                    text: qsTr("Description")
                }
            }

            TextEdit {
                id: textDesc
                width: parent.width/2
                text: _ESApplication.desc

                onTextChanged: {
                    _ESApplication.desc = this.text
                }
            }
        }

        Row {
            id: rowDate
            width: parent.width
            height: 50

            Rectangle {
                id: label1
                width: parent.width/2
                height: parent.height
                Text{
                    text: qsTr("Date:")
                }
            }

            Rectangle {
                id: btnDtTm
                width: parent.width/2
                height: parent.height
                MouseArea{
                    anchors.fill: parent
                    Text{
                        text: qsTr("Select...")
                    }

                    onClicked:{
                        Qt.createComponent("qrc:/qml/Resources/CalendarPopup.qml").createObject(transaction, {});
                    }
                }
            }
        }

        Row {
            id: rowOkCancel
            width: parent.width
            height: 50

            Rectangle {
                id: btnOK
                width: parent.width/2
                height:parent.height
                color:"grey"
                MouseArea{
                    anchors.fill: parent
                    Text{
                        text: qsTr("SAVE")
                    }

                    onClicked:{
                        _ESApplication.addTransaction()
                        transaction.requestRefresh()
                        transaction.visible = false
                        homeControls.visible = true
                        home.navigation = "home"
                    }
                }
            }

            Rectangle {
                id: btnCancel
                width: parent.width/2
                height: parent.height
                color:"grey"
                MouseArea{
                    anchors.fill: parent
                    Text{
                        text: qsTr("CANCEL")
                    }
                    onClicked:{
                        transaction.visible = false
                        homeControls.visible = true
                        home.navigation = "home"
                    }
                }
            }
        }
    }
}
