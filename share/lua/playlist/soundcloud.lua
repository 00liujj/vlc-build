--[[
 $Id$

 Copyright © 2012, 2015, 2019 the VideoLAN team

 Authors: Cheng Sun <chengsun9atgmail.com>
          Pierre Ynard

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
--]]

-- Probe function.
function probe()
    local path = vlc.path
    path = path:gsub("^www%.", "")
    return ( vlc.access == "http" or vlc.access == "https" )
        and string.match( path, "^soundcloud%.com/.+/.+" )
end

function fix_quotes( value )
    if string.match( value, "^\"" ) then
        return "" -- field was really empty string
    end

    -- TODO: handle escaped backslashes and others
    return string.gsub( value, "\\\"", "\"" )
end

-- Parse function.
function parse()
    while true do
        line = vlc.readline()
        if not line then break end

        -- API endpoint for audio stream URL
        if not stream then
            -- The URL may feature an optional query string: for private
            -- tracks in particular it contains a secret token, e.g.
            -- https://api-v2.soundcloud.com/media/soundcloud:tracks:123456789/986421ee-f9ba-42b2-a642-df8e9761a49b/stream/progressive?secret_token=s-ABCDE
            stream = string.match( line, '"url":"([^"]-/stream/progressive[^"]-)"' )
        end

        -- Metadata
        if not name then
            name = string.match( line, "[\"']title[\"'] *: *\"(.-[^\\])\"" )
            if name then
                name = fix_quotes( name )
            end
        end

        if not description then
            description = string.match( line, "[\"']artwork_url[\"'] *:.-[\"']description[\"'] *: *\"(.-[^\\])\"" )
            if description then
                description = fix_quotes( description )
            end
        end

        if not artist then
            artist = string.match( line, "[\"']username[\"'] *: *\"(.-[^\\])\"" )
            if artist then
                artist = fix_quotes( artist )
            end
        end

        if not arturl then
            arturl = string.match( line, "[\"']artwork_url[\"'] *: *[\"'](.-)[\"']" )
        end
    end

    if stream then
        -- API magic
        local client_id = "1XduoqV99lROqCMpijtDo5WnJmpaLuYm"

        local api = vlc.stream( stream..( string.match( stream, "?" ) and "&" or "?" ).."client_id="..client_id )

        if api then
            local streams = api:readline() -- data is on one line only
            -- This API seems to return a single JSON field
            path = string.match( streams, '"url":"(.-)"' )
        end
    end

    if not path then
        vlc.msg.err( "Couldn't extract soundcloud audio URL, please check for updates to this script" )
        return { }
    end

    return { { path = path, name = name, description = description, artist = artist, arturl = arturl } }
end
