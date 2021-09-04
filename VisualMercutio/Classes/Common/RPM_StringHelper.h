/****************************************************************************
 * ==> RPM_StringHelper ----------------------------------------------------*
 ****************************************************************************
 * Description:  Helper class for strings                                   *
 * Contained in: Common                                                     *
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
#include <string>
#include <mutex>

#define M_EOL   "\r\n"
#define M_WEOL L"\r\n"

/**
* Helper class for strings
*@author Jean-Milost Reymond
*/
class RPM_StringHelper
{
    public:
        /**
        * A thread-safe version of the std::setLocale() function
        *@param category - locale category identifier, one of the LC_xxx macros, may be 0
        *@param pLocale - new locale to select, system locale if nullptr
        *@return previously selected locale
        */
        static std::string SetLocale_ThreadSafe(int category, const char* pLocale);

        /**
        * Converts string to lower case
        *@param str - string to convert
        *@return converted string
        */
        static std::string  ToLowerCase(const std::string&  str);
        static std::wstring ToLowerCase(const std::wstring& str);

        /**
        * Converts string to upper case
        *@param str - string to convert
        *@return converted string
        */
        static std::string  ToUpperCase(const std::string&  str);
        static std::wstring ToUpperCase(const std::wstring& str);

        /**
        * Converts an Utf8 encoded string to Utf16
        *@param str - string to convert
        *@return converted string
        */
        static std::wstring Utf8ToUtf16(const std::string& str);

        /**
        * Converts an Utf16 encoded string to Utf8
        *@param str - string to convert
        *@return converted string
        */
        static std::string Utf16ToUtf8(const std::wstring& str);

        /**
        * Converts a boolean value to string
        *@param value - boolean value to convert
        *@param numeric - if true, the converted string will contain 0/1 instead of true/false
        *@return converted string
        */
        static std::string BoolToStr(bool value, bool numeric = false);

        /**
        * Converts a boolean value to Unicode string
        *@param value - boolean value to convert
        *@param numeric - if true, the converted string will contain 0/1 instead of true/false
        *@return converted string
        */
        static std::wstring BoolToWStr(bool value, bool numeric = false);

        /**
        * Converts a string to a boolean value
        *@param str - string to convert
        *@return converted boolean value
        */
        static bool StrToBool(const std::string&  str);
        static bool StrToBool(const std::wstring& str);
};
