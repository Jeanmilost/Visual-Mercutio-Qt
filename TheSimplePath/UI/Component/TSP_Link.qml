import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

// javascript
import "TSP_JSHelper.js" as JSHelper

/**
* Link (between 2 boxes)
*@author Jean-Milost Reymond
*/
Item
{
    // advanced properties
    property var    m_From:        null // box start connector at which link is attached
    property var    m_To:          null // box end connector at which link is attached, if null link is dragging
    property var    m_PageContent: parent
    property var    m_StartPoint:  getStartPoint()
    property var    m_CenterPoint: getCenterPoint()
    property var    m_EndPoint:    getEndPoint()
    property var    m_LabelPos:    Qt.vector2d(m_StartPoint.x + (((m_EndPoint.x - m_StartPoint.x) / 2.0) - (m_LabelSize.x / 2.0)),
                                               m_StartPoint.y + (((m_EndPoint.y - m_StartPoint.y) / 2.0) - (m_LabelSize.y / 2.0)))
    property var    m_LabelSize:   Qt.vector2d(100, 50)
    property var    m_ArrowSize:   Qt.vector2d(3,   10)
    property string m_Color:       "#202020"
    property string m_BgColor:     "white"
    property string m_TextColor:   "#202020"
    property string m_Title:       ""
    property real   m_ScaleFactor: 1

    // common properties
    id: itLink
    objectName: "itLink"
    anchors.fill: parent

    /**
    * First connection line
    */
    Shape
    {
        // common properties
        id:            shMsgFromLine
        objectName:    "shMsgFromLine"
        anchors.fill:  parent
        layer.samples: 8
        layer.enabled: true
        smooth:        true
        clip:          false

        /**
        * First connection line path
        */
        ShapePath
        {
            // common properties
            id:          spMsgFromLine
            objectName:  "spMsgFromLine"
            strokeColor: m_Color
            fillColor:   "transparent"
            strokeWidth: 1
            startX:      m_StartPoint.x
            startY:      m_StartPoint.y

            /**
            * Line path
            */
            PathLine { x: m_CenterPoint.x; y: m_CenterPoint.y }
        }
    }

    /**
    * Second connection line
    */
    Shape
    {
        // common properties
        id:            shMsgToLine
        objectName:    "shMsgToLine"
        anchors.fill:  parent
        layer.samples: 8
        layer.enabled: true
        smooth:        true
        clip:          false

        /**
        * Second connection line path
        */
        ShapePath
        {
            // common properties
            id:          spMsgToLine
            objectName:  "spMsgToLine"
            strokeColor: m_Color
            fillColor:   "transparent"
            strokeWidth: 1
            startX:      m_CenterPoint.x
            startY:      m_CenterPoint.y

            /**
            * Line path
            */
            PathLine { x: m_EndPoint.x; y: m_EndPoint.y }
        }

        /**
        * Arrow
        */
        ShapePath
        {
            property var m_Dir:    Qt.vector2d(m_EndPoint.x - m_CenterPoint.x, m_EndPoint.y - m_CenterPoint.y).normalized()
            property var m_DirCCW: Qt.vector2d(-m_Dir.y,  m_Dir.x)
            property var m_DirCW:  Qt.vector2d( m_Dir.y, -m_Dir.x)

            // common properties
            id:          spMsgArrow
            objectName:  "spMsgArrow"
            strokeColor: m_Color
            fillColor:   m_Color
            strokeWidth: 1
            startX:      m_CenterPoint.x
            startY:      m_CenterPoint.y

            /**
            * Arrow path
            */
            PathMove { x: m_EndPoint.x; y: m_EndPoint.y }
            PathLine { x: m_EndPoint.x - (m_ArrowSize.y * spMsgArrow.m_Dir.x) + (m_ArrowSize.x * spMsgArrow.m_DirCCW.x)
                       y: m_EndPoint.y - (m_ArrowSize.y * spMsgArrow.m_Dir.y) + (m_ArrowSize.x * spMsgArrow.m_DirCCW.y) }
            PathLine { x: m_EndPoint.x - (m_ArrowSize.y * spMsgArrow.m_Dir.x) + (m_ArrowSize.x * spMsgArrow.m_DirCW.x)
                       y: m_EndPoint.y - (m_ArrowSize.y * spMsgArrow.m_Dir.y) + (m_ArrowSize.x * spMsgArrow.m_DirCW.y)  }
        }
    }

    /**
    * Background
    */
    Rectangle
    {
        // advanced properties
        property int m_MouseStartX: 0
        property int m_MouseStartY: 0

        // common properties
        id:         rcBackground
        objectName: "rcBackground"
        x:          m_LabelPos.x
        y:          m_LabelPos.y
        width:      m_LabelSize.x
        height:     m_LabelSize.y
        color:      "transparent"
        visible:    m_From !== null && m_To !== null

        // signals
        signal moveStart()
        signal move(int deltaX, int deltaY)
        signal moveEnd()
        signal resize(int direction, int deltaX, int deltaY)

        /**
        * Handle control
        */
        TSP_HandleControl
        {
            // common properties
            id:           hcBackground
            objectName:   "hcBackground"
            anchors.fill: parent
            z:            rcBackground.activeFocus ? 0 : -1

            // advanced properties
            m_HandleVisible: rcBackground.activeFocus
            m_Target: rcBackground

            // aliases
            handleBackground.border.color: m_Color
        }

        /**
        * Link content
        */
        Rectangle
        {
            // common properties
            id:           rcContent
            objectName:   "rcContent"
            anchors.fill: parent
            color:        m_BgColor
            border.color: m_Color
            border.width: 1
            radius:       3
            z:            rcBackground.activeFocus ? -1 : 0

            /**
            * Link label
            */
            Text
            {
                // common properties
                id:                  txLabel
                objectName:          "txLabel"
                text:                m_Title
                anchors.fill:        parent
                anchors.margins:     2
                font.family:         "Arial"
                font.pointSize:      10
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment:   Text.AlignVCenter
                wrapMode:            Text.WordWrap
                color:               m_TextColor
                clip:                true
            }

            /**
            * Link mouse area
            */
            MouseArea
            {
                // common properties
                id: maMouseArea
                objectName: "maMouseArea"
                anchors.fill: parent

                /// called when the view is clicked
                onClicked:
                {
                    rcBackground.forceActiveFocus();
                }
            }
        }

        /// called when box starts to move
        onMoveStart: function()
        {
            m_MouseStartX = x;
            m_MouseStartY = y;
        }

        /// called when box is moving
        onMove: function(deltaX, deltaY)
        {
            if (!m_PageContent)
                return;

            // move box and limit it in owning page
            x += deltaX;
            x  = JSHelper.clamp(x, 0, m_PageContent.width - width);
            y += deltaY;
            y  = JSHelper.clamp(y, 0, m_PageContent.height - height);

            const linkX      = x      * m_ScaleFactor;
            const linkY      = y      * m_ScaleFactor;
            const linkWidth  = width  * m_ScaleFactor;
            const linkHeight = height * m_ScaleFactor;

            // notify that auto-scroll may be applied
            m_PageContent.doAutoScroll(linkX, linkX + linkWidth, linkY, linkY + linkHeight);
        }

        /// called when box ends to move
        onMoveEnd: function()
        {
            // was control dragged?
            if (Math.abs(x - m_MouseStartX) >= 5 || Math.abs(y - m_MouseStartY) >= 5)
                return;

            if (m_PageContent)
                m_PageContent.doDisableMoveSize(this);
        }

        /// called when box should be resized
        onResize: function(direction, deltaX, deltaY)
        {
            // resize box width
            if (deltaX)
                switch (direction)
                {
                    case TSP_Handle.IEDirection.IE_D_Left:
                    case TSP_Handle.IEDirection.IE_D_LeftTop:
                    case TSP_Handle.IEDirection.IE_D_LeftBottom:
                        x     += deltaX;
                        width -= deltaX;

                        if (x < 0 || width < 30)
                        {
                            x     -= deltaX;
                            width += deltaX;
                        }

                        break;

                    case TSP_Handle.IEDirection.IE_D_Right:
                    case TSP_Handle.IEDirection.IE_D_RightTop:
                    case TSP_Handle.IEDirection.IE_D_RightBottom:
                        width += deltaX;

                        if (width < 30)
                            width -= deltaX;

                        break;
                }

            // resize box height
            if (deltaY)
                switch (direction)
                {
                    case TSP_Handle.IEDirection.IE_D_Top:
                    case TSP_Handle.IEDirection.IE_D_LeftTop:
                    case TSP_Handle.IEDirection.IE_D_RightTop:
                        y      += deltaY;
                        height -= deltaY;

                        if (y < 0 || height < 30)
                        {
                            y      -= deltaY;
                            height += deltaY;
                        }

                        break;

                    case TSP_Handle.IEDirection.IE_D_Bottom:
                    case TSP_Handle.IEDirection.IE_D_LeftBottom:
                    case TSP_Handle.IEDirection.IE_D_RightBottom:
                        height += deltaY;

                        if (height < 30)
                            height -= deltaY;

                        break;
                }
        }
    }

    /**
    * Signal connectors
    */
    Connections
    {
        target: pageContent

        /**
        * Called when the page scale factor changed
        *@param {number} factor - scale factor
        */
        function onPageScaleChanged(factor)
        {
            m_ScaleFactor = factor;
        }
    }

    /**
    * Called when the from connector changed
    */
    onM_FromChanged:
    {
        //console.log("onM_FromChanged");
        bindMsgToSrcBox();
    }

    /**
    * Called when the to connector changed
    */
    onM_ToChanged:
    {
        //console.log("onM_ToChanged");
        bindMsgToDstBox();
    }

    /**
    * Bind link to source box
    */
    function bindMsgToSrcBox()
    {
        // from connector should be defined
        if (!m_From)
            return;

        // unbind link from parent box, if previously binded
        unbindMsgFromBox(m_From.m_Box);
        m_From.m_Links.push(this);
    }

    /**
    * Bind link to destination box
    */
    function bindMsgToDstBox()
    {
        // to connector should be defined
        if (!m_To)
            return;

        // unbind link from parent box, if previously binded
        unbindMsgFromBox(m_To.m_Box);
        m_To.m_Links.push(this);
    }

    /**
    * Unbinds a link from a box
    *@param {TSP_Box} box - box for which the link should be unbind
    */
    function unbindMsgFromBox(box)
    {
        if (!box)
            return 0;

        // remove all existing link instance from left connector
        for (var i = box.leftConnector.m_Links.length - 1; i >= 0; --i)
            if (box.leftConnector.m_Links[i] === this)
                box.leftConnector.m_Links.splice(i, 1);

        // remove all existing link instance from top connector
        for (var i = box.topConnector.m_Links.length - 1; i >= 0; --i)
            if (box.topConnector.m_Links[i] === this)
                box.topConnector.m_Links.splice(i, 1);

        // remove all existing link instance from right connector
        for (var i = box.rightConnector.m_Links.length - 1; i >= 0; --i)
            if (box.rightConnector.m_Links[i] === this)
                box.rightConnector.m_Links.splice(i, 1);

        // remove all existing link instance from bottom connector
        for (var i = box.bottomConnector.m_Links.length - 1; i >= 0; --i)
            if (box.bottomConnector.m_Links[i] === this)
                box.bottomConnector.m_Links.splice(i, 1);
    }

    /**
    * Gets the start point
    *@return the start point in pixels, empty point on error
    */
    function getStartPoint()
    {
        // from connector should be defined
        if (!m_From)
            return Qt.vector2d(0.0, 0.0);

        return getPoint(m_From);
    }

    /**
    * Gets the end point
    *@return the end point in pixels, empty point on error
    */
    function getEndPoint()
    {
        // to connector should be defined
        if (!m_To)
        {
            // link is dragging, get mouse position from start connector
            if (m_From)
            {
                // get the delta between the connector and its parent box
                let startDelta = getStartDelta(m_From);

                return Qt.vector2d(m_From.m_Box.x + m_From.connectorMouseArea.mouseX + startDelta.x,
                                   m_From.m_Box.y + m_From.connectorMouseArea.mouseY + startDelta.y);
            }

            return Qt.vector2d(0.0, 0.0);
        }

        return getPoint(m_To);
    }

    /**
    * Gets the center point
    *@return the center point on y axis in pixels, empty point on error
    */
    function getCenterPoint()
    {
        return Qt.vector2d(rcBackground.x + (rcBackground.width  / 2.0),
                           rcBackground.y + (rcBackground.height / 2.0));
    }

    /**
    * Gets the point centered in the connector
    *@param {TSP_Connector} connector - the connector for which the center point should be get
    *@return the point centered in the connector in pixels, empty point on error
    */
    function getPoint(connector)
    {
        // connector should be defined
        if (!connector)
            return Qt.vector2d(0.0, 0.0);

        // get the connector parent box
        let box = connector.m_Box;

        // parent box should always be defined in the connector
        if (!box)
            return Qt.vector2d(0.0, 0.0);

        // get the connector center point
        switch (connector.m_Position)
        {
            case TSP_Connector.IEPosition.IE_P_Left:
                return Qt.vector2d(box.x + (connector.x + (connector.width / 2)),
                                   box.y + (box.rectConnectors.height      / 2));

            case TSP_Connector.IEPosition.IE_P_Right:
                return Qt.vector2d(box.x +  connector.x + (connector.width / 2),
                                   box.y + (box.rectConnectors.height      / 2));

            case TSP_Connector.IEPosition.IE_P_Top:
                return Qt.vector2d(box.x + (box.rectConnectors.width        / 2),
                                   box.y + (connector.y + (connector.height / 2)));

            case TSP_Connector.IEPosition.IE_P_Bottom:
                return Qt.vector2d(box.x + (box.rectConnectors.width        / 2),
                                   box.y +  connector.y + (connector.height / 2));

            default:
                console.log("getPoint - unknown connector position - " + connector.m_Position);
                return Qt.vector2d(0.0, 0.0);
        }
    }

    /**
    * Gets the start delta to apply to mouse position
    *@param {TSP_Connector} connector - connector from which the start delta should be calculated
    *@return the start delta in pixels, empty point on error
    */
    function getStartDelta(connector)
    {
        // connector should be defined
        if (!connector)
            return Qt.vector2d(0.0, 0.0);

        // get the connector parent box
        let box = connector.m_Box;

        // parent box should always be defined in the connector
        if (!box)
            return Qt.vector2d(0.0, 0.0);

        // get the connector center point
        switch (connector.m_Position)
        {
            case TSP_Connector.IEPosition.IE_P_Left:
                return Qt.vector2d(connector.x, (box.rectConnectors.height / 2) - (connector.height / 2));

            case TSP_Connector.IEPosition.IE_P_Right:
                return Qt.vector2d(connector.x, (box.rectConnectors.height / 2) - (connector.height / 2));

            case TSP_Connector.IEPosition.IE_P_Top:
                return Qt.vector2d((box.rectConnectors.width  / 2) - (connector.width  / 2), connector.y);

            case TSP_Connector.IEPosition.IE_P_Bottom:
                return Qt.vector2d((box.rectConnectors.width  / 2) - (connector.width  / 2), connector.y);

            default:
                console.log("getStartDelta - unknown connector position - " + connector.m_Position);
                return Qt.vector2d(0.0, 0.0);
        }
    }
}