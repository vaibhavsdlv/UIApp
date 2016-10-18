import QtQuick 2.0
import QtQuick.Controls 1.4

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

        Button {
            id: button3
            text: qsTr("Back")
            width: parent.width

            onClicked:{
                homeControls.visible = true
                transaction.visible = false
                home.navigation = "home"
            }
        }

        Row {
            id: rowTxType
            width: parent.width
            height: 50

            Label {
                id: lblPlus
                text: qsTr("+")
                width: parent.width/2
            }

            Label {
                id: lblMinus
                text: qsTr("-")
                width: parent.width/2
            }
        }
        Row {
            id: rowAmount
            width: parent.width
            height: 50

            Label {
                id: lblAmount
                text: qsTr("Amount:")
                width: parent.width/2
            }

            TextField {
                id: txtAmount
                placeholderText: qsTr("Amount")
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


            Label {
                id: lblAccount
                text: qsTr("Account:")
                width: parent.width/2
            }

            ComboBox {
                id: cbAccount
                editable: false
                model: [ "Card1", "Cash", "Savings" ]
                width: parent.width/2

                onCurrentTextChanged:  {
                    _ESApplication.account = cbAccount.currentText
                }
            }
        }

        Row {
            id: rowExpCategory
            width: parent.width
            height: 50

            Label {
                id: lblExpCategory
                text: qsTr("Category:")
                width:parent.width/2
            }

            ComboBox {
                id: cbExpCategory
                editable: false
                width: parent.width/2
                model: [ "Clothing", "Drinks", "Education", "Food", "Fuel", "Fun", "Health", "Highway", "Hotel", "Merchandise", "Other", "Personal", "Pets", "Restaurant", "Tips", "Transport" ]

                onCurrentTextChanged: {
                    _ESApplication.category = cbExpCategory.currentText
                }
            }
        }

        Row {
            id: rowIncCategory
            width: parent.width
            height: 50

            Label {
                id: lblIncCategory
                text: qsTr("Category:")
                width:parent.width/2
            }

            ComboBox {
                id: cbIncCategory
                editable: false
                width: parent.width/2
                model: [ "Loan", "Salary", "Sales" ]

                onCurrentTextChanged: {
                    _ESApplication.category = cbIncCategory.currentText
                }
            }
        }

        Row {
            id: rowDesc
            width: parent.width
            height: 50

            Label {
                id: lblDesc
                text: qsTr("Description")
                width: parent.width/2
            }

            TextField {
                id: textDesc
                placeholderText: qsTr("Description")
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

            Label {
                id: label1
                width: parent.width/2
                text: qsTr("Date:")
            }

            Button {
                id: btnDtTm
                text: qsTr("Select...")
                width: parent.width/2
                onClicked:{
                    Qt.createComponent("qrc:/qml/Resources/CalendarPopup.qml").createObject(transaction, {});
                }
            }
        }

        Row {
            id: rowCal
            width: parent.width

            Calendar {
                id: calendar1
                visible: false
                onClicked:{
                    _ESApplication.trxDateTime = date
                    btnDtTm.text = _ESApplication.trxDateTime
                    calendar1.visible = false
                }
            }
        }

        Row {
            id: rowOkCancel
            width: parent.width
            height: 50

            Button {
                id: btnOK
                text: qsTr("SAVE")
                width: parent.width/2
                onClicked:{
                    _ESApplication.addTransaction()
                    transaction.requestRefresh()
                    transaction.visible = false
                    homeControls.visible = true
                    home.navigation = "home"
                }
            }

            Button {
                id: btnCancel
                text: qsTr("CANCEL")
                width: parent.width/2
                onClicked:{
                    transaction.visible = false
                    homeControls.visible = true
                    home.navigation = "home"
                }
            }
        }
    }
}
