#!/usr/bin/env python

from __future__ import print_function

import os
import sys

import yaml


def fatal(message, *args):
    print(message % args, file=sys.stderr)
    sys.exit(1)


def load_serverdir(source=os.environ):
    """Loads the --serverdir option."""
    serverdir = source.get('DEVPI_SERVERDIR')
    if not serverdir:
        return
    if not os.path.isdir(serverdir):
        os.mkdir(serverdir)
    return serverdir


def load_ldap_configuration(source=os.environ):
    """Loads the LDAP configuration."""

    def kick_empty(d):
        return {k: v for k, v in d.items() if v not in (None, {})}

    def bool_option(name, default):
        return yaml.load(source.get(name, default))

    def search_option(prefix):
        keys = ['base', 'filter', 'scope', 'attribute_name', 'userdn',
                'password']
        result = {
            key: source.get('{0}_{1}'.format(prefix, key.upper()))
            for key in keys}
        return kick_empty(result)

    ldap_enabled = bool_option('LDAP_ENABLED', 'false')
    if not ldap_enabled:
        return

    result = {
        'url': source.get('LDAP_URL'),
        'user_template': source.get('LDAP_USER_TEMPLATE'),
        'user_search': search_option('LDAP_USER_SEARCH'),
        'group_search': search_option('LDAP_GROUP_SEARCH'),
        'referrals': bool_option('LDAP_REFERRALS', 'true'),
        'reject_as_unknown': bool_option('LDAP_REJECT_AS_UNKNOWN', 'false')}

    # Those validation are duplicated with devpi-ldap but necessary.
    # Because the logger configuration of devpi-ldap is problematic.
    if not result['url']:
        fatal('No url in LDAP config.')
    if result['user_template']:
        if result['user_search']:
            fatal('The LDAP options "user_template" and "user_search" are '
                  'mutually exclusive.')
    else:
        if not result['user_search']:
            fatal('You need to set either "user_template" or "user_search" '
                  'in LDAP config.')

    return {'devpi-ldap': kick_empty(result)}


def write_configuration(name, content):
    target_dir = '/etc/devpi'
    target_path = os.path.join(target_dir, name)
    if not os.path.isdir(target_dir):
        os.mkdir(target_dir)
    with open(target_path, 'w') as target_file:
        target_file.write(content)
    return target_path


def main():
    argv = list(sys.argv)

    serverdir = load_serverdir()
    if serverdir is not None:
        argv.append('--serverdir={0}'.format(serverdir))

    ldap_configuration = load_ldap_configuration()
    if ldap_configuration is not None:
        ldap_content = yaml.dump(
            ldap_configuration, default_flow_style=False, explicit_start=True)
        ldap_path = write_configuration('ldap.yaml', ldap_content)
        argv.append('--ldap-config={0}'.format(ldap_path))

    os.execvp('devpi-server', argv)


if __name__ == '__main__':
    main()
