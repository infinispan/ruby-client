#
# Copyright 2011 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Infinispan
  module Constants
    MAGIC            = 0xA0, 0xA1
    HT_VERSION       = 10

    PUT              = 0x01, 0x02
    GET              = 0x03, 0x04
    PUT_IF_ABSENT    = 0x05, 0x06
    REPLACE          = 0x07, 0x08
    REPLACE_IF       = 0x09, 0x0A
    REMOVE           = 0x0B, 0x0C
    REMOVE_IF        = 0x0D, 0x0E
    CONTAINS         = 0x0F, 0x10
    GET_WITH_VERSION = 0x11, 0x12
    CLEAR            = 0x13, 0x14
    STATS            = 0x15, 0x16
    PING             = 0x17, 0x18
    BULK_GET         = 0x19, 0x1A
    ERROR            = 0x50

  end

  module ResponseCode

    SUCCESS             = 0x00
    NO_ACTION           = 0x01
    INVALID_KEY         = 0x02
    INVALID_MAGIC       = 0x81
    UNKNOWN_COMMAND     = 0x82
    UNKNOWN_VERSION     = 0x83
    REQUEST_PARSE_ERROR = 0x84
    SERVER_ERROR        = 0x85
    SERVER_TIME_OUT     = 0x86

    def self.status_message( response_code )
      case response_code
      when SUCCESS             : "Success"
      when NO_ACTION           : "No action taken"
      when INVALID_KEY         : "Invalid key supplied"
      when INVALID_MAGIC       : "Invalid magic or message"
      when UNKNOWN_COMMAND     : "Unrecognized command"
      when UNKNOWN_VERSION     : "Unrecognized version"
      when REQUEST_PARSE_ERROR : "Request parse error"
      when SERVER_ERROR        : "Server error"
      when SERVER_TIME_OUT     : "Server timeout"
      else                     
        "Unrecognized response code: #{response_code.chr}"
      end
    end
  end
end
