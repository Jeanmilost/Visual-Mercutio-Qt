/****************************************************************************
 * ==> RPM_Attribute -------------------------------------------------------*
 ****************************************************************************
 * Description:  Basic attribute which may be contained in an element       *
 * Contained in: Core                                                       *
 * Developer:    Jean-Milost Reymond                                        *
 ****************************************************************************
 * MIT License - todo FIXME -cFeature -oJean: Set the project name here     *
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
#include <cstdint>
#include <ctime>
#include <string>

// core classes
#include "Core\RPM_Item.h"

/**
* Basic attribute which may be contained in an element
*@author Jean-Milost Reymond
*/
class RPM_Attribute : public RPM_Item
{
    public:
        enum class IEFormat
        {
            IE_Undefined = 0,
            IE_Bool,
            IE_Int8,
            IE_UInt8,
            IE_Int16,
            IE_UInt16,
            IE_Int32,
            IE_UInt32,
            IE_Int64,
            IE_UInt64,
            IE_Float,
            IE_Double,
            IE_String,
            IE_UnicodeString,
            IE_DateTime
        };

        RPM_Attribute();
        virtual ~RPM_Attribute();

        /**
        * Gets the attribute value
        *@return the attribute value
        */
        template <class T>
        T Get() const;

        /**
        * Gets the attribute value
        *@param defVal - default value to return in case the internal type conversion fails
        *@return the attribute value
        */
        virtual bool          Get(bool                defVal)  const;
        virtual std::int8_t   Get(std::int8_t         defVal)  const;
        virtual std::uint8_t  Get(std::uint8_t        defVal)  const;
        virtual std::int16_t  Get(std::int16_t        defVal)  const;
        virtual std::uint16_t Get(std::uint16_t       defVal)  const;
        virtual std::int32_t  Get(std::int32_t        defVal)  const;
        virtual std::uint32_t Get(std::uint32_t       defVal)  const;
        virtual std::int64_t  Get(std::int64_t        defVal)  const;
        virtual std::uint64_t Get(std::uint64_t       defVal)  const;
        virtual float         Get(float               defVal)  const;
        virtual double        Get(double              defVal)  const;
        virtual std::string   Get(const std::string&  defVal)  const;
        virtual std::wstring  Get(const std::wstring& defVal)  const;
        virtual std::tm       Get(const std::tm&      defVal)  const;

        /**
        * Clears the attribute
        */
        virtual void Clear();

    private:
        void*         m_pData  = nullptr;
        IEFormat      m_Format = IEFormat::IE_Undefined;
        std::uint64_t m_Size   = 0;
};

//---------------------------------------------------------------------------
template <class T>
T RPM_Attribute::Get() const
{
    return Get(T(0));
}
//---------------------------------------------------------------------------
