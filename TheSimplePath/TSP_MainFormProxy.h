/****************************************************************************
 * ==> TSP_MainFormProxy ---------------------------------------------------*
 ****************************************************************************
 * Description:  The main form proxy between c++ application and qml        *
 *               interface                                                  *
 * Contained in: Core                                                       *
 * Developer:    Jean-Milost Reymond                                        *
 ****************************************************************************
 * MIT License - The Simple Path                                            *
 *                                                                          *
 * Permission is hereby granted, free of charge, to any person obtaining a  *
 * copy of this software and associated documentation files (the            *
 * "Software"), to deal in the Software without restriction, including      *
 * without limitation the rights to use, copy, modify, merge, publish,      *
 * distribute, sub-license, and/or sell copies of the Software, and to      *
 * permit persons to whom the Software is furnished to do so, subject to    *
 * the following conditions:                                                *
 *                                                                          *
 * The above copyright notice and this permission notice shall be included  *
 * in all copies or substantial portions of the Software.                   *
 *                                                                          *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS  *
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF               *
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   *
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY     *
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,     *
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE        *
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                   *
 ****************************************************************************/

#pragma once

// std
#include <string>

// qt
#include <QObject>
#include <QPageSize>

/**
* Main form proxy
*@author Jean-Milost Reymond
*/
class TSP_MainFormProxy : public QObject
{
    Q_OBJECT

    public:
        /**
        * Constructor
        *@param pParent - parent object owning this object
        */
        TSP_MainFormProxy(QObject* pParent = nullptr);

        virtual ~TSP_MainFormProxy();

        /**
        * Gets page width, in pixels
        *@return page width, in pixels
        */
        virtual Q_INVOKABLE int getPageWidth() const;

        /**
        * Gets page height, in pixels
        *@return page height, in pixels
        */
        virtual Q_INVOKABLE int getPageHeight() const;

        /**
        * Called when the add activity button was clicked on the user interface
        */
        virtual Q_INVOKABLE void onAddActivityClicked();

    private:
        QPageSize m_PageSize;
};