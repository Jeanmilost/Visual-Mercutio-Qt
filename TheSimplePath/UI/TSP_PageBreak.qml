import QtQuick 2.15
import QtQuick.Controls 2.15

// custom qt component
import "Component"

/**
* Start symbol
*@author Jean-Milost Reymond
*/
TSP_Box
{
    // advanced properties
    property string m_NormalURL:  "qrc:/Resources/Images/PageBreak_Logo_Normal.svg"
    property string m_ProcessURL: "qrc:/Resources/Images/PageBreak_Logo_Process.svg"
    property bool   m_IsProcess:  false
    property bool   m_IsExit:     false

    // common properties
    m_Color:       "#202020"
    m_BgColor:     m_IsProcess ? "#009ed6" : "white"
    m_TextColor:   m_IsProcess ? "white"   : "#202020"
    m_Radius:      0
    m_BorderWidth: 2

    // child components
    titleText.anchors.bottom:      rectContents.bottom
    titleText.horizontalAlignment: Text.AlignHCenter
    titleText.verticalAlignment:   Text.AlignVCenter
    descriptionText.visible:       false
    commentsText.visible:          false

    /**
    * Top glyph
    */
    Image
    {
        id: imTopGlyph
        objectName: "imTopGlyph"
        source: m_IsProcess ? m_ProcessURL : m_NormalURL
        sourceSize.width: width
        sourceSize.height:height
        x: -(width  / 2) + 6
        y: -(height / 2) + 2
        width: 60
        height: 50
        fillMode: Image.PreserveAspectFit
        visible: m_IsExit
    }

    /**
    * Bottom glyph
    */
    Image
    {
        id: imBottomGlyph
        objectName: "imBottomGlyph"
        source: m_IsProcess ? m_ProcessURL : m_NormalURL
        sourceSize.width: width
        sourceSize.height:height
        x: parent.width  - (width  / 2) - 6
        y: parent.height - (height / 2) - 2
        width: 60
        height: 50
        fillMode: Image.PreserveAspectFit
        visible: !m_IsExit
    }

    /// called when page break should be resized
    onResize: function(direction, deltaX, deltaY)
    {
        const connectorWidth  = 14;
        const connectorHeight = 14;

        // update connectors positions
        leftConnector.x   =  -((connectorWidth  / 2) + 2);
        topConnector.y    =  -((connectorHeight / 2) + 2);
        rightConnector.x  =   width  + 2 - (connectorWidth  / 2);
        bottomConnector.y =   height + 2 - (connectorHeight / 2);
    }
}