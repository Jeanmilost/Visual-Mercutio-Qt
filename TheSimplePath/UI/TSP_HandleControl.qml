import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 2.15 as T

/**
* Control surrounded by handles, which may be moved and resized
*@author Jean-Milost Reymond
*/
T.Control
{
    // advanced properties
    property var  m_Target:        null
    property bool m_HandleVisible: true

    // common properties
    id: ctHandleControl
    objectName: "ctHandleControl"

    /**
    * Handles control background
    */
    Rectangle
    {
        // common properties
        id: rcHandleControl
        objectName: "rcHandleControl"
        anchors.fill: parent
        color: "transparent"
        border.color: "#202020"
        border.width: 1
        radius: 3

        /**
        * Control mouse area
        */
        MouseArea
        {
            // advanced proeprties
            property int m_MouseStartX: 0
            property int m_MouseStartY: 0
            property int m_MouseDeltaX: 0
            property int m_MouseDeltaY: 0

            // common properties
            id: maHandleControl
            objectName: "maHandleControl"
            anchors.fill: parent
            cursorShape: Qt.SizeAllCursor
            acceptedButtons: Qt.LeftButton
            hoverEnabled: true
            visible: ctHandleControl.m_HandleVisible

            /// called when mouse is pressed above the control
            onPressed: function(mouseEvent)
            {
                if (m_Target)
                {
                    m_MouseStartX = m_Target.x;
                    m_MouseStartY = m_Target.y;
                }

                m_MouseDeltaX = mouseEvent.x - parent.x;
                m_MouseDeltaY = mouseEvent.y - parent.y;
            }

            /// called when mouse is released after pressed above the control
            onReleased: function(mouseEvent)
            {
                // was control dragged?
                if (m_Target && Math.abs(m_Target.x - m_MouseStartX) >= 5 || Math.abs(m_Target.y - m_MouseStartY) >= 5)
                    return;

                doDisableMoveSize();
            }

            /// called when mouse moved on the x axis above the handle
            onMouseXChanged:
            {
                if (!ctHandleControl.m_Target)
                    return;

                if (!pressed)
                    return;

                ctHandleControl.m_Target.x += mouseX - m_MouseDeltaX;
            }

            /// called when mouse moved on the y axis above the handle
            onMouseYChanged:
            {
                if (!ctHandleControl.m_Target)
                    return;

                if (!pressed)
                    return;

                ctHandleControl.m_Target.y += mouseY - m_MouseDeltaY;
            }
        }

        /**
        * Left handle
        */
        TSP_Handle
        {
            // common properties
            id: haLeftHandle
            objectName: "haLeftHandle"
            x:   parent.x                       - 5
            y: ((parent.y + parent.height) / 2) - (height / 2)
            visible: ctHandleControl.m_HandleVisible

            // advanced proeprties
            m_Target: ctHandleControl.m_Target
            m_Direction: TSP_Handle.IEDirection.IE_D_Left
        }

        /**
        * Left and top handle
        */
        TSP_Handle
        {
            // common properties
            id: haLeftTopHandle
            objectName: "haLeftTopHandle"
            x: parent.x - 5
            y: parent.y - 5
            visible: ctHandleControl.m_HandleVisible

            // advanced proeprties
            m_Target: ctHandleControl.m_Target
            m_Direction: TSP_Handle.IEDirection.IE_D_LeftTop
        }

        /**
        * Top handle
        */
        TSP_Handle
        {
            // common properties
            id: haTopHandle
            objectName: "haTopHandle"
            x: ((parent.x + parent.width) / 2) - (width / 2)
            y:  parent.y - 5
            visible: ctHandleControl.m_HandleVisible

            // advanced proeprties
            m_Target: ctHandleControl.m_Target
            m_Direction: TSP_Handle.IEDirection.IE_D_Top
        }

        /**
        * Right and top handle
        */
        TSP_Handle
        {
            // common properties
            id: haTopRightHandle
            objectName: "haTopRightHandle"
            x: (parent.x + parent.width) - 2
            y:  parent.y                 - 5
            visible: ctHandleControl.m_HandleVisible

            // advanced proeprties
            m_Target: ctHandleControl.m_Target
            m_Direction: TSP_Handle.IEDirection.IE_D_RightTop
        }

        /**
        * Right handle
        */
        TSP_Handle
        {
            // common properties
            id: haRightHandle
            objectName: "haRightHandle"
            x:  (parent.x + parent.width)       - 2
            y: ((parent.y + parent.height) / 2) - (height / 2)
            visible: ctHandleControl.m_HandleVisible

            // advanced proeprties
            m_Target: ctHandleControl.m_Target
            m_Direction: TSP_Handle.IEDirection.IE_D_Right
        }

        /**
        * Right and bottom handle
        */
        TSP_Handle
        {
            // common properties
            id: haRightBottomHandle
            objectName: "haRightBottomHandle"
            x: (parent.x + parent.width)  - 2
            y: (parent.y + parent.height) - 2
            visible: ctHandleControl.m_HandleVisible

            // advanced proeprties
            m_Target: ctHandleControl.m_Target
            m_Direction: TSP_Handle.IEDirection.IE_D_RightBottom
        }

        /**
        * Bottom handle
        */
        TSP_Handle
        {
            // common properties
            id: haBottomHandle
            objectName: "haBottomHandle"
            x: ((parent.x + parent.width) / 2) - (width / 2)
            y:  (parent.y + parent.height)     - 2
            visible: ctHandleControl.m_HandleVisible

            // advanced proeprties
            m_Target: ctHandleControl.m_Target
            m_Direction: TSP_Handle.IEDirection.IE_D_Bottom
        }

        /**
        * Left and bottom handle
        */
        TSP_Handle
        {
            // common properties
            id: haBottomLeftHandle
            objectName: "haBottomLeftHandle"
            x:  parent.x                  - 5
            y: (parent.y + parent.height) - 2
            visible: ctHandleControl.m_HandleVisible

            // advanced proeprties
            m_Target: ctHandleControl.m_Target
            m_Direction: TSP_Handle.IEDirection.IE_D_LeftBottom
        }
    }

    /**
    * onDoDisableResizeMove callback function to override
    */
    function doDisableMoveSize()
    {}
}
