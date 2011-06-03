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

MAGIC = 0xA0, 0xA1
HT_VERSION = 10

PUT = 0x01, 0x02
GET = 0x03, 0x04
PUT_IF_ABSENT = 0x05, 0x06
REPLACE = 0x07, 0x08
REPLACE_IF = 0x09, 0x0A
REMOVE = 0x0B, 0x0C
REMOVE_IF = 0x0D, 0x0E
CONTAINS = 0x0F, 0x10
GET_WITH_VERSION = 0x11, 0x12
CLEAR = 0x13, 0x14
STATS = 0x15, 0x16
PING = 0x17, 0x18
BULK_GET = 0x19, 0x1A
ERROR = 0x50
