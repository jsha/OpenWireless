"""
Store and retrieve values from the router's UCI config system.
"""
import subprocess

import common

uci_path = '/sbin/uci'

def get(name):
  try:
    return run(['get', name])
  except subprocess.CalledProcessError, e:
    return None

def set(name, value):
  return run(['set', '%s=%s' % (name, value)])

def commit(namespace):
  return run(['commit', namespace])

def validate(string):
  if len(string) > 200:
    raise Exception('String input to UCI too long.')
  if string.find('\00') != -1:
    raise Exception('Invalid input: contains null bytes.')

def run(args_list):
  args_list.insert(0, uci_path)
  args_list.insert(0, '/usr/bin/sudo')
  map(validate, args_list)
  return subprocess.check_output(args_list).strip()
