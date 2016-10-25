import QtQuick 2.0

Item {
    height:720
    width:480

    Column{
        width: parent.width

        Rectangle {
            id: btnBack
            width: parent.width
            height:50
            color:"grey"
            MouseArea{
                anchors.fill: parent
                Text{
                    text: qsTr("Back")
                }

                onClicked:{
                    homeControls.visible = true
                    about.visible = false
                    home.navigation = "home"
                }
            }
        }

        Image {
            id: image1
            width: parent.width
            height: 100
            source: "qrc:/qml/Resources/banner.png"
        }
        Rectangle{
            width: parent.width
            height: 500
            TextEdit{
                width: parent.width
                height: parent.height
                text: qsTr("\n\nAbout This"+
                           "\n\nversion 0.3"+
                           "\nThis is a simple income/expense management utility."+
                           "\nThe primary target is smart phone users."+
                           "\nThere may be a PC port based on response."+
                           "\n\n"+
                           "\nRoadmap:"+
                           "\n--TODO-- Have at least four database populated charts;"+
                           "\n--DONE-- Allow income/expense records in DB;"+
                           "\n--DONE-- Home screen for navigation and recent trx's;"+
                           "\n--DONE-- Proper About Page with changelog;"+
                           "\n--TODO-- Edit/Delete transactions"+
                           "\n--TODO-- Account Summary on Home Screen"+
                           "\nEnhancements:"+
                           "\nAdd time control;"+
                           "\nColored pie-charts;"+
                           "\nBetter validation in trx form"+
                           "\nTransaction Cards for better view"+
                           "\n\nChangelog:"+
                           "\n0.3"+
                           "\nAdded database populated Chart"+
                           "\nFixed mess with DateTime type in SQLite"+
                           "\nAdded DateTime row in All Transactions"+
                           "\nRefined About page to include full changelog"+
                           "\nAdded Roadmap on About page"+
                           "\n\n"+
                           "\n0.2"+
                           "\nAdded plain chart"+
                           "\nMinor fixes here and there in Transaction page"+
                           "\nAdded back buttons everywhere for easier navigation"+
                           "\nAdded About page"+
                           "\nAdded Clear DB function for resetting database"+
                           "\nAdded calener popup overlay; previously calendar was fixed placed"+
                           "\n\n"+
                           "\n0.1"+
                           "\nPrepared SQLite Database"+
                           "\nPrepared Home page for all options and show last 10 transactions"+
                           "\nPrepared Transactions page for income/expense transactions"+
                           "\nPrepared qml as Resources for easier deployment"
                           )
            }
        }
    }
}
