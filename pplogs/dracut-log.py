#!/usr/bin/python

import sys

# matching prefix : [indentation, blacklist_of_regexs, whitelist_of_regexs]
# blacklist is stronger
# leave on first rule
processes = [
    ['kernel' , [0, [], []]],
    ['systemd-udevd' , [2, [''], []]],
    ['systemd' , [1, [], []]],
    #['dracut-cmdline' , [3, [], []]],
    #['dracut-pre-udev' , [3, [], []]],
    #['dracut-trigger' , [3, [], []]],
    #['dracut-initqueue' , [3, [], []]],
    #['dracut-pre-pivot' , [3, [], []]],
    ['dracut' , [3, [], []]],
    ['' , [0, [], []]],
]

MARK_RES = [['.', ". //lib/dracut/hooks"]]

INDENT_STEP = 4
SHOW_PROCESS = True
PROCESS_LENGTH = 25
SHOW_TIMESTAMP = False
DRACUT_INDENT_STEP = 4

# TODO: per dracut-X
dracut_stack = ['']
backup_stack = []
last_dracut_call = None

def check_pep8(s):
    if s:
        return True

def lsplit(line):
    timestamp = "TIMESTAMP N/A"
    process = "PROCESS N/A"
    tail = "TAIL N/A"
    items = line.split()
    # monotonic timestamps
    if items:
        if items[0][0] == '[':
            timestamp = items[0] + '{: <12}'.format(items[1])
        else:
            if len(items) >= 3:
                timestamp = "%s %s %s" % (items[0], items[1], items[2])
    for i, item in enumerate(items):
        if item == "kernel:" or item.endswith("]:"):
            process = items[i]
            tail = " ".join(items[i+1:])
            break
    return (timestamp, process, tail)

def parse_dracut_tail(tail):
    items = tail.split(" ", 3)
    try:
        loc_info = items[0]
        first_call = items[1]
        if first_call == '.':
            first_call = 'source'
        function = loc_info.split("(", 1)[1][:-2]
    except IndexError:
        return (None, None)
    return (function, first_call)

def indent_or_throw_away(process, tail):
    for candidate, filter in processes:
        if process.startswith(candidate):
            # whitelist
            indent, blacklist, whitelist = filter
            if whitelist:
                for re in whitelist:
                    if re in tail:
                        break
                    else:
                        return None
            for re in blacklist:
                if re in tail:
                    return None
            return indent

try:
    filename = sys.argv[1]
except IndexError:
    filename = 'jctl.txt'

with open(filename) as f:
    function = None
    for line in f:
        timestamp, process, tail = lsplit(line)
        i = indent_or_throw_away(process, tail)
        if i is None:
            continue
        # process dracut
        indent_char = " "
        for mark, re in MARK_RES:
            if re in line:
                indent_char = mark
                break

        dracut_indent = 0
        if process.startswith('dracut-'):
            # TODO None, None
            last_function = function
            function, call = parse_dracut_tail(tail)
            if function is not None:
                if function != dracut_stack[-1]:
                    if function == last_dracut_call:
                        dracut_stack.append(function)
                    else:
                        if function and function not in dracut_stack:
                            if function in backup_stack:
                                idx = backup_stack.index(function)
                                dracut_stack = backup_stack[:idx+1]
                                backup_stack = []
                        else:
                            if function == "":
                                if not (dracut_stack[-1] == last_function and dracut_stack[-2] == function):
                                    backup_stack = dracut_stack[:]
                            while function != dracut_stack[-1]:
                                dracut_stack.pop()
                last_dracut_call = call

            if function == "":
                dracut_indent = 0
            else:
                dracut_indent = len(dracut_stack)-1

        if PROCESS_LENGTH:
            fmt = "{: <%d}" % PROCESS_LENGTH
            process = fmt.format(process)[:PROCESS_LENGTH]
        else:
            process = ""
        if not SHOW_TIMESTAMP:
            timestamp = ""
        tail = tail.lstrip('/')
        print "%s %s%s%s%s%s%s" % (timestamp, process, indent_char, indent_char * i * INDENT_STEP, indent_char, indent_char * dracut_indent * DRACUT_INDENT_STEP, tail)

