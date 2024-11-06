#!/usr/bin/python

import os
import sys
import urllib2
import urlparse
import ConfigParser
import re
import subprocess
import shlex

BASE_URL = 'http://download.devel.redhat.com/rel-eng/'
if len(sys.argv) >= 2:
    BASE_URL = sys.argv[1]
STARTING_URL = BASE_URL
RHEL_PREFIX = "RHEL-7.0"
VALID_PREFIX = os.path.join(BASE_URL, RHEL_PREFIX)
COMPOSE_META = 'compose/metadata/composeinfo.ini'

visited = set()  # tracks visited urls to prevent an infinite loop
seen_composes = set()  # track already seen composes


LINKREGEX = re.compile('<a\s(?:.*?\s)*?href=[\'"](.*?)[\'"].*?>')


def parse_page(url):
    """return all URLs from a given URL"""
    if url not in visited:

        links = LINKREGEX.findall(urllib2.urlopen(url).read())
        for link in (links.pop(0) for _ in xrange(len(links))):
            link = urlparse.urljoin(url, link)
            check_url(link)


def is_valid(url):
    """Check base URL and is only concered about the RHEL release
    we are currently interested in"""
    if url.startswith(VALID_PREFIX):
        return True
    return False


def check_url(url):
    if is_valid(url):
        # check if the compose is finished
        compose_info_url = os.path.join(url, 'STATUS')
        response = urllib2.urlopen(compose_info_url).read().strip()
        if response == "FINISHED":  # only FINISHED composes can be snapshots
            try:
                compose_ini_url = os.path.join(url, COMPOSE_META)
                compose_ini = urllib2.urlopen(compose_ini_url)
                config = ConfigParser.ConfigParser()
                config.readfp(compose_ini)
                compose_id = config.get("compose", "id")
                compose_label = config.get("compose", "label")
                print("%s => %s at %s") % (compose_label, compose_id, url)
            except urllib2.HTTPError:
                # this compose does not have the metadata we need
                pass
            except ConfigParser.NoOptionError:
                # incomplete metadata
                pass
            except:
                # something else
                pass


def get_anaconda_versions():
    """Get anaconda version for given snapshots from Brew"""
    brew_template = "brew latest-build rhel-7.0-snapshot-%d-set anaconda"
    compose_index = 1
    print("Listing Anaconda versions for individual RHEL 7.0 snapshots")
    while True:
        try:
            call = brew_template % compose_index
            output = subprocess.check_output(shlex.split(call))
            # skip the two header lines and then get the first
            # item from the whitespace delimited line
            anaconda_version = output.split('\n')[2].split(" ")[0]
            print("Snapshot %d has %s" % (compose_index, anaconda_version))
        except:
            # import traceback
            # print(traceback.format_exc())

            # if calling brew outright fails, notify the user
            if compose_index == 1:
                print('calling the "brew" tool failed, is is installed properly ?')
            elif compose_index == 5:
                print("there is no snapshot 5")
                continue  # there is no rhel-7.0-snapshot-5-set for some reason
            else:
                break
        finally:
            compose_index += 1


def get_snap_info():
    """parse all links on the base url page"""
    parse_page(STARTING_URL)


def main():
    print("Listing available RHEL 7.0 snapshots")
    get_snap_info()
    get_anaconda_versions()

main()
