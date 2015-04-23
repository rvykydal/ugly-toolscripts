#!/usr/bin/python

import sys
import subprocess
from optparse import OptionParser

filters = {
    "program": ["fcoe", "hostname"],
    "syslog" : ["NetworkManager:", "dhclient:", "ADDRCONF", "network"],
    "messages" : ["NetworkManager:", "dhclient:", "ADDRCONF", "network"],
    "packaging" : ["network"]
    }

if __name__ == "__main__":
    usage = ("usage: %prog [--hourshift=08-13] log1 log2 [log3 [log4 ...]]\n")
    parser = OptionParser(usage)
    parser.add_option("-H", "--hourshift", dest="hourshift", action="store", type="string", default=None)
    (options, args) = parser.parse_args(sys.argv[1:])

    if options.hourshift:
        oldtime = options.hourshift[:2]
        newtime = options.hourshift[3:]

    lines = []

    filecount = 0
    for logname in args:
        filter = []
        for filesub  in filters:
            if filesub in logname:
                filter = filters[filesub]
        filecount += 1
        f = open(logname, 'r')
        for line in f:
            if len(line) < 3 or line[2] != ":":
                continue
            timestamp = line[:12]
            if options.hourshift and line.startswith(newtime):
                timestamp = oldtime + timestamp[2:]
            msg = line[13:].strip()
            if filter:
                for str in filter:
                    if str in line:
                        lines.append([timestamp, msg, filecount])
                        break
            else:
                lines.append([timestamp, msg, filecount])
        f.close()

    lines.sort(key=lambda l:l[0])

    for timestamp, line, filecount in lines:
        tab = " " * (filecount - 1) * 4
        print "%s %s %s" % (timestamp, tab, line)

